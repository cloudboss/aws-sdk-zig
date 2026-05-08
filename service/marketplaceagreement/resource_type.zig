const std = @import("std");

pub const ResourceType = enum {
    agreement,
    agreement_request,
    agreement_proposal,
    charge,
    payment_request,
    invoice,
    agreement_cancellation_request,
    billing_adjustment_request,

    pub const json_field_names = .{
        .agreement = "Agreement",
        .agreement_request = "AgreementRequest",
        .agreement_proposal = "AgreementProposal",
        .charge = "Charge",
        .payment_request = "PaymentRequest",
        .invoice = "Invoice",
        .agreement_cancellation_request = "AgreementCancellationRequest",
        .billing_adjustment_request = "BillingAdjustmentRequest",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agreement => "Agreement",
            .agreement_request => "AgreementRequest",
            .agreement_proposal => "AgreementProposal",
            .charge => "Charge",
            .payment_request => "PaymentRequest",
            .invoice => "Invoice",
            .agreement_cancellation_request => "AgreementCancellationRequest",
            .billing_adjustment_request => "BillingAdjustmentRequest",
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
