const std = @import("std");

pub const SortField = enum {
    updated_at,
    created_at,
    dicom_study_date_and_time,

    pub const json_field_names = .{
        .updated_at = "updatedAt",
        .created_at = "createdAt",
        .dicom_study_date_and_time = "DICOMStudyDateAndTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .updated_at => "updatedAt",
            .created_at => "createdAt",
            .dicom_study_date_and_time => "DICOMStudyDateAndTime",
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
