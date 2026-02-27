const FieldsData = @import("fields_data.zig").FieldsData;
const InternalStreamingException = @import("errors.zig").InternalStreamingException;

/// A stream of structured log data returned by the GetLogObject operation. This
/// stream
/// contains log events with their associated metadata and extracted fields.
pub const GetLogObjectResponseStream = union(enum) {
    fields: ?FieldsData,
    /// An internal error occurred during the streaming of log data. This exception
    /// is thrown when
    /// there's an issue with the internal streaming mechanism used by the
    /// GetLogObject
    /// operation.
    internal_streaming_exception: ?InternalStreamingException,

    pub const json_field_names = .{
        .fields = "fields",
        .internal_streaming_exception = "InternalStreamingException",
    };
};
