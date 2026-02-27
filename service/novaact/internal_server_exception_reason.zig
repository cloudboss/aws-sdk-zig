pub const InternalServerExceptionReason = enum {
    invalid_model_generation,
    token_limit_exceeded,

    pub const json_field_names = .{
        .invalid_model_generation = "INVALID_MODEL_GENERATION",
        .token_limit_exceeded = "TOKEN_LIMIT_EXCEEDED",
    };
};
