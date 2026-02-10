/// Describes a path component.
pub const AnalysisComponent = struct {
    /// The Amazon Resource Name (ARN) of the component.
    arn: ?[]const u8,

    /// The ID of the component.
    id: ?[]const u8,

    /// The name of the analysis component.
    name: ?[]const u8,
};
