const std = @import("std");

pub const ObjectStorageClass = enum {
    standard,
    reduced_redundancy,
    glacier,
    standard_ia,
    onezone_ia,
    intelligent_tiering,
    deep_archive,
    outposts,
    glacier_ir,
    snow,
    express_onezone,
    fsx_openzfs,
    fsx_ontap,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .reduced_redundancy = "REDUCED_REDUNDANCY",
        .glacier = "GLACIER",
        .standard_ia = "STANDARD_IA",
        .onezone_ia = "ONEZONE_IA",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .deep_archive = "DEEP_ARCHIVE",
        .outposts = "OUTPOSTS",
        .glacier_ir = "GLACIER_IR",
        .snow = "SNOW",
        .express_onezone = "EXPRESS_ONEZONE",
        .fsx_openzfs = "FSX_OPENZFS",
        .fsx_ontap = "FSX_ONTAP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .reduced_redundancy => "REDUCED_REDUNDANCY",
            .glacier => "GLACIER",
            .standard_ia => "STANDARD_IA",
            .onezone_ia => "ONEZONE_IA",
            .intelligent_tiering => "INTELLIGENT_TIERING",
            .deep_archive => "DEEP_ARCHIVE",
            .outposts => "OUTPOSTS",
            .glacier_ir => "GLACIER_IR",
            .snow => "SNOW",
            .express_onezone => "EXPRESS_ONEZONE",
            .fsx_openzfs => "FSX_OPENZFS",
            .fsx_ontap => "FSX_ONTAP",
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
