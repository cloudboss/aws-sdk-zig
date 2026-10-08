const PurchaseOptionFilterType = @import("purchase_option_filter_type.zig").PurchaseOptionFilterType;

/// A filter used to narrow purchase option results by product, seller, type,
/// visibility, or availability.
pub const PurchaseOptionFilter = struct {
    /// The type of filter to apply, such as `PRODUCT_ID`, `VISIBILITY_SCOPE`, or
    /// `PURCHASE_OPTION_TYPE`.
    filter_type: PurchaseOptionFilterType,

    /// The values to filter by. Supported values depend on `filterType`:
    ///
    /// * `PRODUCT_ID` – One or more product identifiers to filter by.
    /// * `SELLER_OF_RECORD_PROFILE_ID` – One or more seller profile identifiers to
    ///   filter by.
    /// * `PURCHASE_OPTION_TYPE` – One or more purchase option types to filter by:
    ///   `OFFER` or `OFFERSET`.
    /// * `VISIBILITY_SCOPE` – The visibility scope to filter by: `PRIVATE`.
    /// * `AVAILABILITY_STATUS` – One or more availability statuses to filter by:
    ///   `AVAILABLE` or `EXPIRED`.
    ///
    /// To retrieve private offers and offer sets visible to you, use
    /// `VISIBILITY_SCOPE` with `PRIVATE`. OR logic combines multiple values within
    /// the same filter.
    filter_values: []const []const u8,

    pub const json_field_names = .{
        .filter_type = "filterType",
        .filter_values = "filterValues",
    };
};
