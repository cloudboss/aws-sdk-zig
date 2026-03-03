const Authority = @import("authority.zig").Authority;

/// The tax exemption type.
pub const TaxExemptionType = struct {
    /// The tax exemption's applicable jurisdictions.
    applicable_jurisdictions: ?[]const Authority = null,

    /// The tax exemption's type description.
    description: ?[]const u8 = null,

    /// The tax exemption's type display name.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .applicable_jurisdictions = "applicableJurisdictions",
        .description = "description",
        .display_name = "displayName",
    };
};
