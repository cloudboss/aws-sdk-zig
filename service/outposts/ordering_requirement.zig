const OrderingRequirementType = @import("ordering_requirement_type.zig").OrderingRequirementType;
const OrderingRequirementStatus = @import("ordering_requirement_status.zig").OrderingRequirementStatus;

/// A requirement that must be met before an order can be submitted for a quote.
pub const OrderingRequirement = struct {
    /// The type of ordering requirement. Indicates which check failed or passed.
    ///
    /// * `OUTPOST_ACTIVE_CHECK_ERROR` - The Outpost must be in
    /// an active state.
    ///
    /// * `MAXIMUM_ALLOWED_ORDERS_CHECK_ERROR` - The maximum
    /// number of allowed orders has been reached.
    ///
    /// * `VALID_ZIP_CODE_CHECK_ERROR` - The site address must
    /// have a valid zip code.
    ///
    /// * `RACK_PHYSICAL_PROPERTIES_CHECK_ERROR` - The rack
    /// physical properties do not meet requirements.
    ///
    /// * `OPERATING_ADDRESS_EXISTENCE_CHECK_ERROR` - The site
    /// must have an operating address.
    ///
    /// * `SHIPPING_ADDRESS_EXISTENCE_CHECK_ERROR` - The site
    /// must have a shipping address.
    ///
    /// * `COUNTRY_CODE_MISMATCH_CHECK_ERROR` - The country
    /// code on the quote does not match the Outpost site country.
    ///
    /// * `OUTPOST_GENERATION_MISMATCH_ERROR` - The Outpost generation
    /// does not match the requested configuration.
    ///
    /// * `OUTPOST_ID_MISSING_ON_QUOTE_ERROR` - The quote must
    /// be associated with an Outpost before submitting an order.
    ///
    /// * `ENTERPRISE_SUPPORT_ERROR` - Enterprise Support is
    /// required.
    ///
    /// * `SHIPPING_ADDRESS_MISSING_CONTACT_NAME_ERROR` - The
    /// shipping address must have a contact name.
    ///
    /// * `SHIPPING_ADDRESS_MISSING_CONTACT_NUMBER_ERROR` - The
    /// shipping address must have a contact phone number.
    ///
    /// * `SHIPPING_ADDRESS_MISSING_CONTACT_INFO_ERROR` - The
    /// shipping address must have contact information.
    ///
    /// * `OUTPOST_STATE_CHANGED_ERROR` - The Outpost state has
    /// changed since the quote was created.
    ///
    /// * `OUTPOST_NOT_FOUND_ERROR` - The Outpost associated
    /// with the quote was not found.
    ///
    /// * `OUTPOST_RENEWAL_REQUIRED_ERROR` - The Outpost
    /// requires a renewal before a new order can be submitted.
    ///
    /// * `UNSUPPORTED` - The requirement type is not
    /// recognized.
    ordering_requirement_type: ?OrderingRequirementType = null,

    /// The status of the ordering requirement. Valid values are `PASS`,
    /// `FAIL`, and `EXEMPT`.
    status: ?OrderingRequirementStatus = null,

    /// A message about the ordering requirement.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .ordering_requirement_type = "OrderingRequirementType",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
