const ObjectPart = @import("object_part.zig").ObjectPart;

/// A collection of parts associated with a multipart upload.
pub const GetObjectAttributesParts = struct {
    /// Indicates whether the returned list of parts is truncated. A value of `true`
    /// indicates
    /// that the list was truncated. A list can be truncated if the number of parts
    /// exceeds the limit returned
    /// in the `MaxParts` element.
    is_truncated: ?bool,

    /// The maximum number of parts allowed in the response.
    max_parts: ?i32,

    /// When a list is truncated, this element specifies the last part in the list,
    /// as well as the value to
    /// use for the `PartNumberMarker` request parameter in a subsequent request.
    next_part_number_marker: ?[]const u8,

    /// The marker for the current part.
    part_number_marker: ?[]const u8,

    /// A container for elements related to a particular part. A response can
    /// contain zero or more
    /// `Parts` elements.
    ///
    /// **Note:**
    ///
    /// * **General purpose buckets** - For
    /// `GetObjectAttributes`, if an additional checksum (including
    /// `x-amz-checksum-crc32`, `x-amz-checksum-crc32c`,
    /// `x-amz-checksum-sha1`, or `x-amz-checksum-sha256`) isn't applied to the
    /// object specified in the request, the response doesn't return the `Part`
    /// element.
    ///
    /// * **Directory buckets** - For
    /// `GetObjectAttributes`, regardless of whether an additional checksum is
    /// applied to the
    /// object specified in the request, the response returns the `Part` element.
    parts: ?[]const ObjectPart,

    /// The total number of parts.
    total_parts_count: ?i32,
};
