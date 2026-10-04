const ProgrammingLanguage = @import("programming_language.zig").ProgrammingLanguage;

/// Identifies a code location to instrument, including the programming
/// language, code unit, class, method, file path, and optional line number.
pub const CodeLocation = struct {
    /// The class or type name that contains the method. This is required for Java
    /// and optional for Python module-level functions.
    class_name: ?[]const u8 = null,

    /// The package, module, or namespace that contains the target code, for example
    /// `com.amazon.payment` or `payment_service`.
    code_unit: ?[]const u8 = null,

    /// The source file path relative to the project or source root, such as
    /// `src/payment/PaymentProcessor.java` or `src/payment/PaymentProcessor.py`.
    file_path: []const u8,

    /// The programming language for this instrumentation point, such as Java,
    /// Python, or JavaScript.
    language: ProgrammingLanguage,

    /// The line number to instrument. Provide this to disambiguate overloaded
    /// methods and to target a specific line when needed.
    line_number: ?i32 = null,

    /// The method or function name to instrument, such as `validateCreditCard` or
    /// `__init__`.
    method_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .class_name = "ClassName",
        .code_unit = "CodeUnit",
        .file_path = "FilePath",
        .language = "Language",
        .line_number = "LineNumber",
        .method_name = "MethodName",
    };
};
