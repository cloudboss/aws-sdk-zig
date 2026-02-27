const ListDomainsAttributeName = @import("list_domains_attribute_name.zig").ListDomainsAttributeName;
const Operator = @import("operator.zig").Operator;

/// Information for the filtering of a list of domains returned by
/// [ListDomains](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains__ListDomains.html).
pub const FilterCondition = struct {
    /// Name of the field which should be used for filtering the list of domains.
    name: ListDomainsAttributeName,

    /// The operator values for filtering domain names. The values can be:
    ///
    /// * `LE`: Less than, or equal to
    ///
    /// * `GE`: Greater than, or equal to
    ///
    /// * `BEGINS_WITH`: Begins with
    operator: Operator,

    /// An array of strings presenting values to compare. Only 1 item in the list is
    /// currently supported.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .values = "Values",
    };
};
