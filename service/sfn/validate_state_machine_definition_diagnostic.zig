const ValidateStateMachineDefinitionSeverity = @import("validate_state_machine_definition_severity.zig").ValidateStateMachineDefinitionSeverity;

/// Describes potential issues found during state machine validation. Rather
/// than raise an
/// exception, validation will return a list of **diagnostic
/// elements** containing diagnostic information.
///
/// The
/// [ValidateStateMachineDefinitionlAPI](https://docs.aws.amazon.com/step-functions/latest/apireference/API_ValidateStateMachineDefinition.html) might add
/// new diagnostics in the future, adjust diagnostic codes, or change the
/// message
/// wording. Your automated processes should only rely on the value of the
/// **result** field value (OK, FAIL). Do **not** rely on the exact order,
/// count, or
/// wording of diagnostic messages.
///
/// **List of warning codes**
///
/// **NO_DOLLAR**
///
/// No `.$` on a field that appears to be a JSONPath or Intrinsic Function.
///
/// **NO_PATH**
///
/// Field value looks like a path, but field name does not end with 'Path'.
///
/// **PASS_RESULT_IS_STATIC**
///
/// Attempt to use a path in the result of a pass state.
///
/// **List of error codes**
///
/// **INVALID_JSON_DESCRIPTION**
///
/// JSON syntax problem found.
///
/// **MISSING_DESCRIPTION**
///
/// Received a null or empty workflow input.
///
/// **SCHEMA_VALIDATION_FAILED**
///
/// Schema validation reported errors.
///
/// **INVALID_RESOURCE**
///
/// The value of a Task-state resource field is invalid.
///
/// **MISSING_END_STATE**
///
/// The workflow does not have a terminal state.
///
/// **DUPLICATE_STATE_NAME**
///
/// The same state name appears more than once.
///
/// **INVALID_STATE_NAME**
///
/// The state name does not follow the naming convention.
///
/// **STATE_MACHINE_NAME_EMPTY**
///
/// The state machine name has not been specified.
///
/// **STATE_MACHINE_NAME_INVALID**
///
/// The state machine name does not follow the naming convention.
///
/// **STATE_MACHINE_NAME_TOO_LONG**
///
/// The state name exceeds the allowed length.
///
/// **STATE_MACHINE_NAME_ALREADY_EXISTS**
///
/// The state name already exists.
///
/// **DUPLICATE_LABEL_NAME**
///
/// A label name appears more than once.
///
/// **INVALID_LABEL_NAME**
///
/// You have provided an invalid label name.
///
/// **MISSING_TRANSITION_TARGET**
///
/// The value of "Next" field doesn't match a known state name.
///
/// **TOO_DEEPLY_NESTED**
///
/// The states are too deeply nested.
pub const ValidateStateMachineDefinitionDiagnostic = struct {
    /// Identifying code for the diagnostic.
    code: []const u8,

    /// Location of the issue in the state machine, if available.
    ///
    /// For errors specific to a field, the location could be in the format:
    /// `/States//`, for example: `/States/FailState/ErrorPath`.
    location: ?[]const u8,

    /// Message describing the diagnostic condition.
    message: []const u8,

    /// A value of `ERROR` means that you cannot create or update a state machine
    /// with this definition.
    ///
    /// `WARNING` level diagnostics alert you to potential issues, but they will not
    /// prevent you from creating or updating your state machine.
    severity: ValidateStateMachineDefinitionSeverity,

    pub const json_field_names = .{
        .code = "code",
        .location = "location",
        .message = "message",
        .severity = "severity",
    };
};
