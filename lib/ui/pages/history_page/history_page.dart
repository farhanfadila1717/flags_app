import 'package:flags_app/core/redux/action_mapper.dart';
import 'package:flags_app/ui/components/tts_card.dart';
import 'package:flags_app/ui/components/tts_mixin.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulActionMapper {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with TtsMixin {
  @override
  void initState() {
    super.initState();
    initTts(_kText);
  }

  @override
  void dispose() {
    speakingWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(color: Colors.white),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            'assets/images/flag_bg.png',
            alignment: Alignment.bottomCenter,
            opacity: const AlwaysStoppedAnimation(0.1),
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/bg_kuis.png',
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
            opacity: const AlwaysStoppedAnimation(0.1),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Sejarah Bendera'),
          ),
          floatingActionButton: TtsCard(
            speakingWord: speakingWord,
            ttsState: ttsState,
            onPlay: playAudio,
            onPause: flutterTts.stop,
          ),
          backgroundColor: Colors.transparent,
          body: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              children: const [
                Text(
                  _kText,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const _kText =
    '''Secara historis, bendera berasal dari standar militer , digunakan sebagai tanda lapangan.

Sepanjang sejarah, berbagai contoh bendera proto tersebut ada: spanduk kain putih tentara dinasti Zhou pada abad ke-11 SM, standar vexillum yang dikibarkan oleh tentara Kekaisaran Romawi , Standar Hitam yang terkenal dibawa oleh Muhammad yang kemudian menjadi bendera Kekhalifahan Abbasiyah , dan berbagai " panji gagak " yang dikibarkan oleh para kepala suku Viking . Angelino Dulcert menerbitkan serangkaian bagan Portolan yang komprehensif pada abad ke-14 M, yang terkenal menampilkan gambar bendera beberapa negara – meskipun ini bukan "bendera nasional" yang seragam, karena beberapa kemungkinan merupakan standar pribadi penguasa negara masing-masing.
          
Praktek mengibarkan bendera yang menunjukkan negara asal di luar konteks peperangan menjadi hal yang biasa terjadi pada bendera maritim . Desain bendera Belanda saat ini berasal dari varian Prinsenvlag ("Bendera Pangeran") yang berwarna oranye-putih-biru pada akhir abad ke-16, yang digunakan dalam Perang Kemerdekaan Belanda (1568–1648), yang berkembang pada awal Abad ke-17 sebagai Statenvlag ("Bendera Negara") merah-putih-biru , bendera angkatan laut Negara -Jenderal Republik Belanda , menjadikan bendera Belanda mungkin bendera tiga warna tertua yang terus digunakan, meskipun standarisasi warna yang tepat masih dilakukan. jauh di kemudian hari.  
          
Pada zaman layar di awal abad ke-17, Union Jack menemukan asal-usulnya, ketika James VI dari Skotlandia mewarisi takhta Inggris dan Irlandia (sebagai James I). Pada tanggal 12 April 1606, bendera baru yang mewakili persatuan agung antara Inggris dan Skotlandia ditetapkan dalam dekrit kerajaan, yang menyatakan bahwa bendera Inggris (palang merah dengan latar belakang putih, dikenal sebagai Salib St George ), dan bendera Inggris Skotlandia ( saltire putih dengan latar belakang biru, yang dikenal sebagai Saltire atau St Andrew's Cross), akan digabungkan, membentuk bendera Britania Raya dan Union Flag pertama  - tetapi kemudian tanpa Palang merah St. Patrick . Bendera ini terus digunakan sampai tanggal 1 Januari 1801, tanggal efektif penyatuan legislatif Inggris Raya dan Irlandia, ketika Salib St. Patrick (salib diagonal merah di atas putih) dimasukkan ke dalam bendera,  memberikan Union Jack desainnya saat ini.
          
Dengan munculnya sentimen nasionalis pada akhir abad ke-18, bendera nasional juga mulai ditampilkan dalam konteks sipil.  Contoh awal yang penting termasuk bendera AS , yang pertama kali diadopsi sebagai panji angkatan laut pada tahun 1777 tetapi mulai ditampilkan sebagai simbol umum Amerika Serikat setelah Revolusi Amerika , dan Tiga Warna Prancis , yang menjadi simbol Amerika Serikat. Republik pada tahun 1790-an. 
          
Sebagian besar negara di Eropa melakukan standarisasi dan kodifikasi desain bendera maritim mereka sebagai bendera nasional, pada abad ke-19 dan awal abad ke-20. Spesifikasi bendera Denmark , berdasarkan bendera yang terus digunakan sejak abad ke-14, dikodifikasikan pada tahun 1748, sebagai bendera persegi panjang dengan proporsi tertentu, menggantikan variannya dengan belahan.  Bendera Swiss diperkenalkan pada tahun 1889, juga didasarkan pada bendera perang abad pertengahan.
          
Di Eropa, desain tiga warna merah-putih-biru pada bendera Kerajaan Belanda menjadi populer, karena dikaitkan dengan bentuk pemerintahan republik melalui perang kemerdekaan yang panjang melawan Kerajaan Spanyol . Asosiasi tersebut semakin diperkuat setelah Revolusi Perancis (1789), ketika Perancis menggunakan warna yang sama, namun dengan garis vertikal dan bukan garis horizontal. Negara-negara lain di Eropa (seperti Irlandia , Rumania , dan Estonia ) serta di Amerika Selatan dan Tengah memilih tiga warna mereka sendiri untuk menyatakan kepatuhan mereka terhadap prinsip-prinsip kebebasan, kesetaraan, dan persaudaraan sebagaimana terkandung dalam bendera Prancis.
Bendera Ottoman (sekarang bendera Turki) diadopsi pada tahun 1844. Negara-negara non-Eropa lainnya mengikuti tren ini pada akhir abad ke-19, bendera Qing Besar diperkenalkan pada tahun 1862, dan bendera Jepang diperkenalkan pada tahun 1870. Juga pada tahun 1870. Abad ke-19, sebagian besar negara di Amerika Selatan memperkenalkan bendera saat mereka merdeka ( Peru pada tahun 1820, Bolivia pada tahun 1851, Kolombia pada tahun 1860, Brasil pada tahun 1822, dll.)
          
Saat ini, terdapat 193 bendera nasional di dunia yang dikibarkan oleh negara-negara berdaulat yang tergabung dalam PBB.''';
