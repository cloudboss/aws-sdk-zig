const AttributeMatchingModel = @import("attribute_matching_model.zig").AttributeMatchingModel;

/// Configuration information about the `AttributeTypesSelector `where the
/// rule-based identity resolution uses to match profiles. You can choose how
/// profiles are
/// compared across attribute types and which attribute to use for matching from
/// each type.
/// There are three attribute types you can configure:
///
/// * Email type
///
/// * You can choose from `Email`, `BusinessEmail`, and
/// `PersonalEmail`
///
/// * Phone number type
///
/// * You can choose from `Phone`, `HomePhone`, and
/// `MobilePhone`
///
/// * Address type
///
/// * You can choose from `Address`, `BusinessAddress`,
/// `MaillingAddress`, and `ShippingAddress`
///
/// You can either choose `ONE_TO_ONE` or `MANY_TO_MANY` as the
/// `AttributeMatchingModel`. When choosing `MANY_TO_MANY`, the system
/// can match attribute across the sub-types of an attribute type. For example,
/// if the value of
/// the `Email` field of Profile A and the value of `BusinessEmail` field
/// of Profile B matches, the two profiles are matched on the Email type. When
/// choosing
/// `ONE_TO_ONE` the system can only match if the sub-types are exact matches.
/// For example, only when the value of the `Email` field of Profile A and the
/// value
/// of the `Email` field of Profile B matches, the two profiles are matched on
/// the
/// Email type.
pub const AttributeTypesSelector = struct {
    /// The `Address` type. You can choose from `Address`,
    /// `BusinessAddress`, `MaillingAddress`, and
    /// `ShippingAddress`.
    ///
    /// You only can use the Address type in the `MatchingRule`. For example, if you
    /// want to match profile based on `BusinessAddress.City` or
    /// `MaillingAddress.City`, you need to choose the `BusinessAddress`
    /// and the `MaillingAddress` to represent the Address type and specify the
    /// `Address.City` on the matching rule.
    address: ?[]const []const u8 = null,

    /// Configures the `AttributeMatchingModel`, you can either choose
    /// `ONE_TO_ONE` or `MANY_TO_MANY`.
    attribute_matching_model: AttributeMatchingModel,

    /// The `Email` type. You can choose from `EmailAddress`,
    /// `BusinessEmailAddress` and `PersonalEmailAddress`.
    ///
    /// You only can use the `EmailAddress` type in the `MatchingRule`.
    /// For example, if you want to match profile based on `PersonalEmailAddress` or
    /// `BusinessEmailAddress`, you need to choose the
    /// `PersonalEmailAddress` and the `BusinessEmailAddress` to represent
    /// the `EmailAddress` type and only specify the `EmailAddress` on the
    /// matching rule.
    email_address: ?[]const []const u8 = null,

    /// The `PhoneNumber` type. You can choose from `PhoneNumber`,
    /// `HomePhoneNumber`, and `MobilePhoneNumber`.
    ///
    /// You only can use the `PhoneNumber` type in the `MatchingRule`. For
    /// example, if you want to match a profile based on `Phone` or
    /// `HomePhone`, you need to choose the `Phone` and the
    /// `HomePhone` to represent the `PhoneNumber` type and only specify
    /// the `PhoneNumber` on the matching rule.
    phone_number: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .address = "Address",
        .attribute_matching_model = "AttributeMatchingModel",
        .email_address = "EmailAddress",
        .phone_number = "PhoneNumber",
    };
};
