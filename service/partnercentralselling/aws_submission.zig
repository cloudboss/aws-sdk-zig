const SalesInvolvementType = @import("sales_involvement_type.zig").SalesInvolvementType;
const Visibility = @import("visibility.zig").Visibility;

/// Indicates the level of AWS involvement in the opportunity. This field helps
/// track AWS participation throughout the engagement, such as providing
/// technical support, deal assistance, and sales support.
pub const AwsSubmission = struct {
    /// Specifies the type of AWS involvement in the opportunity, such as coselling,
    /// deal support, or technical consultation. This helps categorize the nature of
    /// AWS participation.
    involvement_type: SalesInvolvementType,

    /// Determines who can view AWS involvement in the opportunity. Typically, this
    /// field is set to `Full` for most cases, but it may be restricted based on
    /// special program requirements or confidentiality needs.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .involvement_type = "InvolvementType",
        .visibility = "Visibility",
    };
};
