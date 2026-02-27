const LensStatus = @import("lens_status.zig").LensStatus;
const LensType = @import("lens_type.zig").LensType;

/// A lens summary of a lens.
pub const LensSummary = struct {
    created_at: ?i64,

    description: ?[]const u8,

    lens_alias: ?[]const u8,

    /// The ARN of the lens.
    lens_arn: ?[]const u8,

    lens_name: ?[]const u8,

    /// The status of the lens.
    lens_status: ?LensStatus,

    /// The type of the lens.
    lens_type: ?LensType,

    /// The version of the lens.
    lens_version: ?[]const u8,

    owner: ?[]const u8,

    updated_at: ?i64,

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
