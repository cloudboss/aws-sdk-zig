const FileShareType = @import("file_share_type.zig").FileShareType;

/// Describes a file share. Only supported S3 File Gateway.
pub const FileShareInfo = struct {
    file_share_arn: ?[]const u8 = null,

    file_share_id: ?[]const u8 = null,

    file_share_status: ?[]const u8 = null,

    file_share_type: ?FileShareType = null,

    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_share_arn = "FileShareARN",
        .file_share_id = "FileShareId",
        .file_share_status = "FileShareStatus",
        .file_share_type = "FileShareType",
        .gateway_arn = "GatewayARN",
    };
};
