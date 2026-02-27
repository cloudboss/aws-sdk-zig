const FieldName = @import("field_name.zig").FieldName;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A list of fields, comparators and value that you can use to filter the
/// crawler runs for a specified crawler.
pub const CrawlsFilter = struct {
    /// A key used to filter the crawler runs for a specified crawler. Valid values
    /// for each of the field names are:
    ///
    /// * `CRAWL_ID`: A string representing the UUID identifier for a crawl.
    ///
    /// * `STATE`: A string representing the state of the crawl.
    ///
    /// * `START_TIME` and `END_TIME`: The epoch timestamp in milliseconds.
    ///
    /// * `DPU_HOUR`: The number of data processing unit (DPU) hours used for the
    ///   crawl.
    field_name: ?FieldName,

    /// The value provided for comparison on the crawl field.
    field_value: ?[]const u8,

    /// A defined comparator that operates on the value. The available operators
    /// are:
    ///
    /// * `GT`: Greater than.
    ///
    /// * `GE`: Greater than or equal to.
    ///
    /// * `LT`: Less than.
    ///
    /// * `LE`: Less than or equal to.
    ///
    /// * `EQ`: Equal to.
    ///
    /// * `NE`: Not equal to.
    filter_operator: ?FilterOperator,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .field_value = "FieldValue",
        .filter_operator = "FilterOperator",
    };
};
