const aws = @import("aws");

const LimitClass = @import("limit_class.zig").LimitClass;

/// The class and attributes that identify a specific limit at the account
/// level.
pub const LimitDefinitionType = struct {
    /// The attributes that identify the specific limit. For API rate limits,
    /// specify the
    /// `Category` key with a value like `UserAuthentication` or
    /// `UserCreation`.
    attributes: []const aws.map.StringMapEntry,

    /// The class of the limit. For API rate limits, this is
    /// `API_CATEGORY`.
    limit_class: LimitClass,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .limit_class = "LimitClass",
    };
};
