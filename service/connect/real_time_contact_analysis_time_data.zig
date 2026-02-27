/// Object describing time with which the segment is associated. It can have
/// different representations of time.
/// Currently supported: absoluteTime
pub const RealTimeContactAnalysisTimeData = union(enum) {
    /// Time represented in ISO 8601 format: yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    absolute_time: ?i64,

    pub const json_field_names = .{
        .absolute_time = "AbsoluteTime",
    };
};
