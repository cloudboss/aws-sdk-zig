const std = @import("std");

/// The method Lambda uses to store a function's deployment package — either by
/// copying the package into Lambda-managed storage (`COPY`) or by referencing
/// it directly from the source Amazon S3 bucket (`REFERENCE`).
pub const S3ObjectStorageMode = enum {
    /// The default storage mode. Uploads a copy of your deployment package to
    /// Lambda.
    copy,
    /// The reference storage mode. Lambda references the deployment package from
    /// the specified Amazon S3 bucket without uploading a copy.
    reference,

    pub const json_field_names = .{
        .copy = "COPY",
        .reference = "REFERENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .copy => "COPY",
            .reference => "REFERENCE",
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
