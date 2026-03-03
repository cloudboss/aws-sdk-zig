const std = @import("std");

pub const GeneratedManifestFormat = enum {
    s3_inventory_report_csv_20211130,

    pub const json_field_names = .{
        .s3_inventory_report_csv_20211130 = "S3InventoryReport_CSV_20211130",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3_inventory_report_csv_20211130 => "S3InventoryReport_CSV_20211130",
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
