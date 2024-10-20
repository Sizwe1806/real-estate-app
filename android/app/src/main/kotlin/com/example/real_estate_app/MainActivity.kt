package com.example.real_estate_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.pathprovider.PathProviderPlugin;
class MainActivity: FlutterActivity()

@Override
protected void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  PathProviderPlugin.registerWith(registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
}