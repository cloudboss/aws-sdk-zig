const std = @import("std");

pub const AwsManagedHumanLoopRequestSource = enum {
    rekognition_detect_moderation_labels_image_v3,
    textract_analyze_document_forms_v1,

    pub const json_field_names = .{
        .rekognition_detect_moderation_labels_image_v3 = "AWS/Rekognition/DetectModerationLabels/Image/V3",
        .textract_analyze_document_forms_v1 = "AWS/Textract/AnalyzeDocument/Forms/V1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rekognition_detect_moderation_labels_image_v3 => "AWS/Rekognition/DetectModerationLabels/Image/V3",
            .textract_analyze_document_forms_v1 => "AWS/Textract/AnalyzeDocument/Forms/V1",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
