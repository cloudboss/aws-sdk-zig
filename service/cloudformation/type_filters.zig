const Category = @import("category.zig").Category;

/// Filter criteria to use in determining which extensions to return.
pub const TypeFilters = struct {
    /// The category of extensions to return.
    ///
    /// * `REGISTERED`: Private extensions that have been registered for this
    ///   account and
    /// Region.
    ///
    /// * `ACTIVATED`: Public extensions that have been activated for this account
    ///   and
    /// Region.
    ///
    /// * `THIRD_PARTY`: Extensions available for use from publishers other than
    ///   Amazon.
    /// This includes:
    ///
    /// * Private extensions registered in the account.
    ///
    /// * Public extensions from publishers other than Amazon, whether activated or
    ///   not.
    ///
    /// * `AWS_TYPES`: Extensions available for use from Amazon.
    category: ?Category,

    /// The id of the publisher of the extension.
    ///
    /// Extensions published by Amazon aren't assigned a publisher ID. Use the
    /// `AWS_TYPES` category to specify a list of types published by Amazon.
    publisher_id: ?[]const u8,

    /// A prefix to use as a filter for results.
    type_name_prefix: ?[]const u8,
};
