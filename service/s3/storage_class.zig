const std = @import("std");

pub const StorageClass = enum {
    standard,
    reduced_redundancy,
    standard_ia,
    onezone_ia,
    intelligent_tiering,
    glacier,
    deep_archive,
    outposts,
    glacier_ir,
    snow,
    express_onezone,
    fsx_openzfs,
    fsx_ontap,
    aws_backup_warm,
    aws_backup_low_cost_warm,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .reduced_redundancy = "REDUCED_REDUNDANCY",
        .standard_ia = "STANDARD_IA",
        .onezone_ia = "ONEZONE_IA",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .glacier = "GLACIER",
        .deep_archive = "DEEP_ARCHIVE",
        .outposts = "OUTPOSTS",
        .glacier_ir = "GLACIER_IR",
        .snow = "SNOW",
        .express_onezone = "EXPRESS_ONEZONE",
        .fsx_openzfs = "FSX_OPENZFS",
        .fsx_ontap = "FSX_ONTAP",
        .aws_backup_warm = "AWS_BACKUP_WARM",
        .aws_backup_low_cost_warm = "AWS_BACKUP_LOW_COST_WARM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .reduced_redundancy => "REDUCED_REDUNDANCY",
            .standard_ia => "STANDARD_IA",
            .onezone_ia => "ONEZONE_IA",
            .intelligent_tiering => "INTELLIGENT_TIERING",
            .glacier => "GLACIER",
            .deep_archive => "DEEP_ARCHIVE",
            .outposts => "OUTPOSTS",
            .glacier_ir => "GLACIER_IR",
            .snow => "SNOW",
            .express_onezone => "EXPRESS_ONEZONE",
            .fsx_openzfs => "FSX_OPENZFS",
            .fsx_ontap => "FSX_ONTAP",
            .aws_backup_warm => "AWS_BACKUP_WARM",
            .aws_backup_low_cost_warm => "AWS_BACKUP_LOW_COST_WARM",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
