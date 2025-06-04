import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: 'https://ehojbrcvontsiloyacau.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVob2picmN2b250c2lsb3lhY2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg1OTcxODIsImV4cCI6MjA2NDE3MzE4Mn0.b5TXB6DacWCbMENVIR-tpW4wuZKINykvKnnqzzGrYRc',
  );
}
