/// Specifies the byte range of the object to get the records from. A record is
/// processed when its first
/// byte is contained by the range. This parameter is optional, but when
/// specified, it must not be empty.
/// See RFC 2616, Section 14.35.1 about how to specify the start and end of the
/// range.
pub const ScanRange = struct {
    /// Specifies the end of the byte range. This parameter is optional. Valid
    /// values: non-negative
    /// integers. The default value is one less than the size of the object being
    /// queried. If only the End
    /// parameter is supplied, it is interpreted to mean scan the last N bytes of
    /// the file. For example,
    /// `50` means scan the last 50
    /// bytes.
    end: ?i64,

    /// Specifies the start of the byte range. This parameter is optional. Valid
    /// values: non-negative
    /// integers. The default value is 0. If only `start` is supplied, it means scan
    /// from that point
    /// to the end of the file. For example,
    /// `50` means scan from byte 50
    /// until the end of the file.
    start: ?i64,
};
