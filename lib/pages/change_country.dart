import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/country_language.dart';
import 'package:provider/provider.dart';

import '../colors/app_colors.dart';

class ChangeCountry extends StatefulWidget {
  const ChangeCountry({super.key});

  @override
  State<ChangeCountry> createState() => _ChangeCountryState();
}

class _ChangeCountryState extends State<ChangeCountry> {
  List<Map<String, String>> filteredCountries = [];
  List<Map<String, String>> allCountries = [];
  @override
  void initState() {
    final provider =
        Provider.of<CountryAndLanguageServices>(context, listen: false);
    // TODO: implement initState

    allCountries = provider.allCountries;
    filteredCountries = allCountries;
    super.initState();
  }

  void _runFilter(String searchedCountry) {
    List<Map<String, String>> results = [];
    if (searchedCountry.isEmpty) {
      results = allCountries;
    } else {
      results = allCountries.where((country) {
        return country['country']!
            .toLowerCase()
            .contains(searchedCountry.toLowerCase());
      }).toList();
    }
    setState(() {
      filteredCountries = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: size.width * .9,
            height: 50,
            child: TextField(
              onChanged: (value) {
                _runFilter(value);
              },
              decoration: const InputDecoration(
                fillColor: AppColors.lightgrey,
                filled: true,
                hintText: 'Search country...',
                hintStyle: TextStyle(color: AppColors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: filteredCountries.isEmpty
                ? const Center(child: Text('No Country Found'))
                : ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: ListTile(
                          onTap: () {
                            CountryAndLanguageServices.defaultCountryCode =
                                filteredCountries[index]['code']!;
                            Navigator.pop(context);
                          },
                          leading: CountryFlag.fromCountryCode(
                            filteredCountries[index]['code']
                                .toString()
                                .toUpperCase(),
                            width: 50,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                filteredCountries[index]['country'].toString(),
                                style: const TextStyle(fontSize: 15)),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
