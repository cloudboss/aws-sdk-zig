const std = @import("std");

pub const PhoneNumberOrderStatus = enum {
    processing,
    successful,
    failed,
    partial,
    pending_documents,
    submitted,
    foc,
    change_requested,
    exception,
    cancel_requested,
    cancelled,

    pub const json_field_names = .{
        .processing = "Processing",
        .successful = "Successful",
        .failed = "Failed",
        .partial = "Partial",
        .pending_documents = "PendingDocuments",
        .submitted = "Submitted",
        .foc = "FOC",
        .change_requested = "ChangeRequested",
        .exception = "Exception",
        .cancel_requested = "CancelRequested",
        .cancelled = "Cancelled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .processing => "Processing",
            .successful => "Successful",
            .failed => "Failed",
            .partial => "Partial",
            .pending_documents => "PendingDocuments",
            .submitted => "Submitted",
            .foc => "FOC",
            .change_requested => "ChangeRequested",
            .exception => "Exception",
            .cancel_requested => "CancelRequested",
            .cancelled => "Cancelled",
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
