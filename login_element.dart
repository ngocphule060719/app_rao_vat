import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sugitomo/extension/theme_data_ext.dart';
import 'package:sugitomo/ui/page/login/login_loading_provider.dart';
import 'package:sugitomo/ui/router.dart';

class LoginButtonWidget extends ConsumerWidget {
  const LoginButtonWidget({super.key, this.color, this.textColor});

  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context);
    final isLoading = ref.watch(isLoadingProvider);
    final appColors = Theme.of(context).appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            primary: color ?? appColors.mainPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: isLoading
              ? () {}
              : () {
                  openLoginByWebView(context, ref);
                },
          child: Center(
            child: Text(
              l.loginOrRegister,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> openLoginByWebView(BuildContext context, WidgetRef ref) async {
    final navigator = Navigator.of(context);
    ref.read(isLoadingProvider.notifier).state = true;
    if (navigator.mounted) {
      LoginRoute().push(context);
    }
    ref.read(isLoadingProvider.notifier).state = false;
  }
}
