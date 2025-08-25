import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/features/local/cubit/locale_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> supportedLocales = context.supportedLocales;

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, selectedLocale) {
        return Scaffold(
          appBar: AppBar(title: Text('language'.tr())),
          body: ListView.separated(
            itemCount: supportedLocales.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              Locale locale = supportedLocales[index];
              bool isSelected =
                  locale.languageCode == selectedLocale.languageCode &&
                  locale.countryCode == selectedLocale.countryCode;

              return RadioListTile<Locale>(
                value: locale,
                groupValue: selectedLocale,
                onChanged: (Locale? value) {
                  if (value != null) {
                    context.setLocale(value);
                    context.read<LocaleCubit>().changeLanguage(value);
                  }
                },
                title: Text(
                  '${locale.languageCode.toUpperCase()} - ${locale.countryCode ?? ''}',
                  style: isSelected
                      ? TextStyles.font14BlueSemiBold(context)
                      : TextStyles.font14GrayRegular(context),
                ),
                activeColor: Colors.blue,
                secondary: isSelected
                    ? Icon(Icons.check_circle, color: Colors.blue)
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}
