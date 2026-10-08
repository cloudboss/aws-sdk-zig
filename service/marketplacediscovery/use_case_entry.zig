const UseCase = @import("use_case.zig").UseCase;

/// An entry in the list of use cases for a listing.
pub const UseCaseEntry = struct {
    /// The use case details.
    use_case: UseCase,

    pub const json_field_names = .{
        .use_case = "useCase",
    };
};
