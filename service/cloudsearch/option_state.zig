const std = @import("std");

/// The state of processing a change to an option. One of:
///
/// * RequiresIndexDocuments: The option's latest value will not be deployed
///   until IndexDocuments has been called and indexing is complete.
///
/// * Processing: The option's latest value is in the process of being
///   activated.
///
/// * Active: The option's latest value is fully deployed.
///
/// * FailedToValidate: The option value is not compatible with the domain's
///   data and cannot be used to index the data. You must either modify the
///   option value or update or remove the incompatible documents.
pub const OptionState = enum {
    requires_index_documents,
    processing,
    active,
    failed_to_validate,

    pub const json_field_names = .{
        .requires_index_documents = "RequiresIndexDocuments",
        .processing = "Processing",
        .active = "Active",
        .failed_to_validate = "FailedToValidate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requires_index_documents => "RequiresIndexDocuments",
            .processing => "Processing",
            .active => "Active",
            .failed_to_validate => "FailedToValidate",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
