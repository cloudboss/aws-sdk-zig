/// Information about whether a file is binary or textual in a merge or pull
/// request operation.
pub const IsBinaryFile = struct {
    /// The binary or non-binary status of a file in the base of a merge or pull
    /// request.
    base: ?bool = null,

    /// The binary or non-binary status of a file in the destination of a merge or
    /// pull request.
    destination: ?bool = null,

    /// The binary or non-binary status of file in the source of a merge or pull
    /// request.
    source: ?bool = null,

    pub const json_field_names = .{
        .base = "base",
        .destination = "destination",
        .source = "source",
    };
};
