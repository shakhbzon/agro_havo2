import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Crop {
    final String id;
    final String name;
    final String emoji;
    final DateTime plantDate; 
    final Color bgColor;
    final Color graphColor;

    Crop({
          required this.id,
          required this.name,
          required this.emoji,
          required this.plantDate,
          required this.bgColor,
          required this.graphColor,
    });

    int get daysSincePlanted => DateTime.now().difference(plantDate).inDays;

    String get stage {
          final days = daysSincePlanted;
          if (days < 7) return 'stage_seed';
          if (days < 30) return 'stage_seedling';
          if (days < 60) return 'stage_growing';
          if (days < 90) return 'stage_flowering';
          return 'stage_mature';
    }

    String get stageEmoji {
          final days = daysSincePlanted;
          if (days < 7) return '    final days = daysSincePlanted;
              if (days < 7) return '[seed]';
                  if (days < 30) return '[seedling]';
                      if (days < 60) return '[growing]';
                          if (days < 90) return '[flowering]';
                              return '[mature]';
                                }

                                  String get status {
                                      final days = daysSincePlanted;
                                          if (days < 3) return 'status_new';
                                              if (days < 14) return 'status_need_water';
                                                  if (days < 45) return 'status_growing';
                                                      if (days < 80) return 'status_need_care';
                                                          return 'status_ready';
                                                            }

                                                              String get formattedDate {
                                                                  const months = [
                                                                        '', 'Yanvar', 'Fevral', 'Mart', 'Aprel', 'May', 'Iyun',
                                                                              'Iyul', 'Avgust', 'Sentyabr', 'Oktyabr', 'Noyabr', 'Dekabr'
                                                                                  ];
                                                                                      return '${plantDate.day}-${months[plantDate.month]}, ${plantDate.year}';
                                                                                        }
                                                                                        }

                                                                                        class CropAdapter extends TypeAdapter<Crop> {
                                                                                          @override
                                                                                            final int typeId = 0;

                                                                                              @override
                                                                                                Crop read(BinaryReader reader) {
                                                                                                    return Crop(
                                                                                                          id: reader.readString(),
                                                                                                                name: reader.readString(),
                                                                                                                      emoji: reader.readString(),
                                                                                                                            plantDate: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
                                                                                                                                  bgColor: Color(reader.readInt()),
                                                                                                                                        graphColor: Color(reader.readInt()),
                                                                                                                                            );
                                                                                                                                              }
                                                                                                                                              
                                                                                                                                                @override
                                                                                                                                                  void write(BinaryWriter writer, Crop obj) {
                                                                                                                                                      writer.writeString(obj.id);
                                                                                                                                                          writer.writeString(obj.name);
                                                                                                                                                              writer.writeString(obj.emoji);
                                                                                                                                                                  writer.writeInt(obj.plantDate.millisecondsSinceEpoch);
                                                                                                                                                                      writer.writeInt(obj.bgColor.value);
                                                                                                                                                                          writer.writeInt(obj.graphColor.value);
                                                                                                                                                                            }
                                                                                                                                                                            }
                                                                                                                                                                            
