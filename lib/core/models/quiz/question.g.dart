// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      no: json['no'] as num,
      question: json['question'] as String,
      image: json['image'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      audio: json['audio'] as String,
      level: json['level'] as num,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'no': instance.no,
      'question': instance.question,
      'image': instance.image,
      'answers': instance.answers,
      'audio': instance.audio,
      'level': instance.level,
    };
