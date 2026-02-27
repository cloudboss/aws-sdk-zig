const AddonCompatibilityDetail = @import("addon_compatibility_detail.zig").AddonCompatibilityDetail;
const DeprecationDetail = @import("deprecation_detail.zig").DeprecationDetail;

/// Summary information that relates to the category of the insight. Currently
/// only
/// returned with certain insights having category `UPGRADE_READINESS`.
pub const InsightCategorySpecificSummary = struct {
    /// A list of `AddonCompatibilityDetail` objects for Amazon EKS add-ons.
    addon_compatibility_details: ?[]const AddonCompatibilityDetail,

    /// The summary information about deprecated resource usage for an insight check
    /// in the
    /// `UPGRADE_READINESS` category.
    deprecation_details: ?[]const DeprecationDetail,

    pub const json_field_names = .{
        .addon_compatibility_details = "addonCompatibilityDetails",
        .deprecation_details = "deprecationDetails",
    };
};
