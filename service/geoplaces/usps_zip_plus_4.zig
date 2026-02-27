const RecordTypeCode = @import("record_type_code.zig").RecordTypeCode;

/// The USPS zip+4 code.
pub const UspsZipPlus4 = struct {
    /// The USPS ZIP+4 Record Type Code.
    record_type_code: ?RecordTypeCode,

    pub const json_field_names = .{
        .record_type_code = "RecordTypeCode",
    };
};
