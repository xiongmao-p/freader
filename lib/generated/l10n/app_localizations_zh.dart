// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get bookshelf => '书架';

  @override
  String get addBook => '添加书籍';

  @override
  String get search => '搜索';

  @override
  String get searchBooks => '搜索书籍...';

  @override
  String get noBooksFound => '未找到书籍。';

  @override
  String get noBooksYet => '书架上还没有书。';

  @override
  String get welcomeToFReader => '欢迎使用 FReader！';

  @override
  String get deleteBook => '删除书籍';

  @override
  String get areYouSureYouWantToDeleteThisBook => '您确定要删除这本书吗？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get bookAddedSuccessfully => '书籍添加成功！';

  @override
  String get bookDeletedSuccessfully => '书籍删除成功！';

  @override
  String failedToAddBook(Object error) {
    return '添加书籍失败：$error';
  }

  @override
  String get reader => '阅读器';

  @override
  String get settings => '设置';

  @override
  String get theme => '主题';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get fontSize => '字号';

  @override
  String get chapters => '目录';

  @override
  String get bookSources => '书源';

  @override
  String get addBookSource => '添加书源';

  @override
  String get editBookSource => '编辑书源';

  @override
  String get bookSourceName => '名称';

  @override
  String get bookSourceUrl => '地址';

  @override
  String get save => '保存';

  @override
  String get noResultsFound => '未找到结果。';

  @override
  String get startSearchingToAddBooks => '开始搜索以添加书籍。';

  @override
  String get noBookSourcesYet => '还没有书源。';

  @override
  String get welcomeToBookSources => '欢迎来到书源管理！';

  @override
  String get pleaseEnterAName => '请输入名称';

  @override
  String get pleaseEnterAUrl => '请输入地址';

  @override
  String get rulesJson => '规则 (JSON)';

  @override
  String get deleteBookSource => '删除书源';

  @override
  String areYouSureYouWantToDeleteSource(String sourceName) {
    return '您确定要删除 “$sourceName” 吗？';
  }

  @override
  String get bookSourceType => '书源类型';

  @override
  String get html => 'HTML';

  @override
  String get api => 'API';

  @override
  String get loadingChapter => '正在加载章节...';

  @override
  String fontSizeLabel(String fontSizeValue) {
    return '字号: $fontSizeValue';
  }
}
