const std = @import("std");

pub const PatchFilterKey = enum {
    arch,
    advisory_id,
    bugzilla_id,
    patch_set,
    product,
    product_family,
    classification,
    cve_id,
    epoch,
    msrc_severity,
    name,
    patch_id,
    section,
    priority,
    repository,
    release,
    severity,
    security,
    version,

    pub const json_field_names = .{
        .arch = "ARCH",
        .advisory_id = "ADVISORY_ID",
        .bugzilla_id = "BUGZILLA_ID",
        .patch_set = "PATCH_SET",
        .product = "PRODUCT",
        .product_family = "PRODUCT_FAMILY",
        .classification = "CLASSIFICATION",
        .cve_id = "CVE_ID",
        .epoch = "EPOCH",
        .msrc_severity = "MSRC_SEVERITY",
        .name = "NAME",
        .patch_id = "PATCH_ID",
        .section = "SECTION",
        .priority = "PRIORITY",
        .repository = "REPOSITORY",
        .release = "RELEASE",
        .severity = "SEVERITY",
        .security = "SECURITY",
        .version = "VERSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arch => "ARCH",
            .advisory_id => "ADVISORY_ID",
            .bugzilla_id => "BUGZILLA_ID",
            .patch_set => "PATCH_SET",
            .product => "PRODUCT",
            .product_family => "PRODUCT_FAMILY",
            .classification => "CLASSIFICATION",
            .cve_id => "CVE_ID",
            .epoch => "EPOCH",
            .msrc_severity => "MSRC_SEVERITY",
            .name => "NAME",
            .patch_id => "PATCH_ID",
            .section => "SECTION",
            .priority => "PRIORITY",
            .repository => "REPOSITORY",
            .release => "RELEASE",
            .severity => "SEVERITY",
            .security => "SECURITY",
            .version => "VERSION",
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
