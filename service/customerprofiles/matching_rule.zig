/// Specifies how does the rule-based matching process should match profiles.
/// You can choose
/// from the following attributes to build the matching Rule:
///
/// * AccountNumber
///
/// * Address.Address
///
/// * Address.City
///
/// * Address.Country
///
/// * Address.County
///
/// * Address.PostalCode
///
/// * Address.State
///
/// * Address.Province
///
/// * BirthDate
///
/// * BusinessName
///
/// * EmailAddress
///
/// * FirstName
///
/// * Gender
///
/// * LastName
///
/// * MiddleName
///
/// * PhoneNumber
///
/// * Any customized profile attributes that start with the
/// `Attributes`
pub const MatchingRule = struct {
    /// A single rule level of the `MatchRules`. Configures how the rule-based
    /// matching process should match profiles.
    rule: []const []const u8,

    pub const json_field_names = .{
        .rule = "Rule",
    };
};
