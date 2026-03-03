/// A structure that defines a key and values that you can use to filter the
/// results. The only performance events that are returned are those that have
/// values matching the ones that you specify in one of your `QueryFilter`
/// structures.
///
/// For example, you could specify `Browser` as the `Name` and specify
/// `Chrome,Firefox` as the `Values` to return events generated only from those
/// browsers.
///
/// Specifying `Invert` as the `Name` works as a "not equal to" filter. For
/// example, specify `Invert` as the `Name` and specify `Chrome` as the value to
/// return all events except events from user sessions with the Chrome browser.
pub const QueryFilter = struct {
    /// The name of a key to search for. The filter returns only the events that
    /// match the `Name` and `Values` that you specify.
    ///
    /// Valid values for `Name` are `Browser` | `Device` | `Country` | `Page` | `OS`
    /// | `EventType` | `Invert`
    name: ?[]const u8 = null,

    /// The values of the `Name` that are to be be included in the returned results.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
