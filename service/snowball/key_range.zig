/// Contains a key range. For export jobs, a `S3Resource` object can have an
/// optional `KeyRange` value. The length of the range is defined at job
/// creation, and
/// has either an inclusive `BeginMarker`, an inclusive `EndMarker`, or
/// both. Ranges are UTF-8 binary sorted.
pub const KeyRange = struct {
    /// The key that starts an optional key range for an export job. Ranges are
    /// inclusive and
    /// UTF-8 binary sorted.
    begin_marker: ?[]const u8,

    /// The key that ends an optional key range for an export job. Ranges are
    /// inclusive and
    /// UTF-8 binary sorted.
    end_marker: ?[]const u8,

    pub const json_field_names = .{
        .begin_marker = "BeginMarker",
        .end_marker = "EndMarker",
    };
};
