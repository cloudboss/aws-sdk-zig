/// Defines the source of a key
pub const KeyOrigin = enum {
    external,
    aws_payment_cryptography,

    pub const json_field_names = .{
        .external = "EXTERNAL",
        .aws_payment_cryptography = "AWS_PAYMENT_CRYPTOGRAPHY",
    };
};
