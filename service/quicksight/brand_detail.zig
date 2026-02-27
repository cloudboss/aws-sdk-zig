const BrandStatus = @import("brand_status.zig").BrandStatus;
const Logo = @import("logo.zig").Logo;
const BrandVersionStatus = @import("brand_version_status.zig").BrandVersionStatus;

/// The details of the brand.
pub const BrandDetail = struct {
    /// The Amazon Resource Name (ARN) of the brand.
    arn: ?[]const u8,

    /// The ID of the Quick Suite brand.
    brand_id: []const u8,

    /// The status of the brand.
    brand_status: ?BrandStatus,

    /// The time that the brand was created.
    created_time: ?i64,

    /// A list of errors that occurred during the most recent brand operation.
    errors: ?[]const []const u8,

    /// The last time the brand was updated.
    last_updated_time: ?i64,

    /// The logo details.
    logo: ?Logo,

    /// The ID of the version.
    version_id: ?[]const u8,

    /// The status of the version.
    version_status: ?BrandVersionStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .brand_id = "BrandId",
        .brand_status = "BrandStatus",
        .created_time = "CreatedTime",
        .errors = "Errors",
        .last_updated_time = "LastUpdatedTime",
        .logo = "Logo",
        .version_id = "VersionId",
        .version_status = "VersionStatus",
    };
};
