const DnsValidationChallenge = @import("dns_validation_challenge.zig").DnsValidationChallenge;
const EmailValidationChallenge = @import("email_validation_challenge.zig").EmailValidationChallenge;

/// Contains the challenge details that you use to prove domain ownership. Only
/// one member is set, depending on the validation method.
pub const ValidationChallenge = union(enum) {
    dns_validation_challenge: ?DnsValidationChallenge,
    email_validation_challenge: ?EmailValidationChallenge,

    pub const json_field_names = .{
        .dns_validation_challenge = "DnsValidationChallenge",
        .email_validation_challenge = "EmailValidationChallenge",
    };
};
