const BrandStatus = @import("brand_status.zig").BrandStatus;

/// A summary of the brand.
pub const BrandSummary = struct {
    /// The Amazon Resource Name (ARN) of the brand.
    arn: ?[]const u8 = null,

    /// The ID of the Quick Suite brand.
    brand_id: ?[]const u8 = null,

    /// The name of the brand.
    brand_name: ?[]const u8 = null,

    /// The status of the brand.
    brand_status: ?BrandStatus = null,

    /// The time that the brand was created.
    created_time: ?i64 = null,

    /// The description of the brand.
    description: ?[]const u8 = null,

    /// The time when the brand was last updated.
    last_updated_time: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .brand_id = "BrandId",
        .brand_name = "BrandName",
        .brand_status = "BrandStatus",
        .created_time = "CreatedTime",
        .description = "Description",
        .last_updated_time = "LastUpdatedTime",
    };
};
