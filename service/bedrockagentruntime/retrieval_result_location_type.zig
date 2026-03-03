const std = @import("std");

pub const RetrievalResultLocationType = enum {
    s3,
    web,
    confluence,
    salesforce,
    sharepoint,
    custom,
    kendra,
    sql,

    pub const json_field_names = .{
        .s3 = "S3",
        .web = "WEB",
        .confluence = "CONFLUENCE",
        .salesforce = "SALESFORCE",
        .sharepoint = "SHAREPOINT",
        .custom = "CUSTOM",
        .kendra = "KENDRA",
        .sql = "SQL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3 => "S3",
            .web => "WEB",
            .confluence => "CONFLUENCE",
            .salesforce => "SALESFORCE",
            .sharepoint => "SHAREPOINT",
            .custom => "CUSTOM",
            .kendra => "KENDRA",
            .sql => "SQL",
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
