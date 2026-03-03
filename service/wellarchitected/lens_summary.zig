const LensStatus = @import("lens_status.zig").LensStatus;
const LensType = @import("lens_type.zig").LensType;

/// A lens summary of a lens.
pub const LensSummary = struct {
    created_at: ?i64 = null,

    description: ?[]const u8 = null,

    lens_alias: ?[]const u8 = null,

    /// The ARN of the lens.
    lens_arn: ?[]const u8 = null,

    lens_name: ?[]const u8 = null,

    /// The status of the lens.
    lens_status: ?LensStatus = null,

    /// The type of the lens.
    lens_type: ?LensType = null,

    /// The version of the lens.
    lens_version: ?[]const u8 = null,

    owner: ?[]const u8 = null,

    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .lens_name = "LensName",
        .lens_status = "LensStatus",
        .lens_type = "LensType",
        .lens_version = "LensVersion",
        .owner = "Owner",
        .updated_at = "UpdatedAt",
    };
};
