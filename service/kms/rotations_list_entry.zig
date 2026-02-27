const ExpirationModelType = @import("expiration_model_type.zig").ExpirationModelType;
const ImportState = @import("import_state.zig").ImportState;
const KeyMaterialState = @import("key_material_state.zig").KeyMaterialState;
const RotationType = @import("rotation_type.zig").RotationType;

/// Each entry contains information about one of the key materials associated
/// with a KMS
/// key.
pub const RotationsListEntry = struct {
    /// Indicates if the key material is configured to automatically expire. There
    /// are two
    /// possible values for this field: `KEY_MATERIAL_EXPIRES` and
    /// `KEY_MATERIAL_DOES_NOT_EXPIRE`. For any key material that expires, the
    /// expiration
    /// date and time is indicated in `ValidTo`. This field is only present for
    /// symmetric
    /// encryption KMS keys with `EXTERNAL` origin.
    expiration_model: ?ExpirationModelType,

    /// Indicates if the key material is currently imported into KMS. It has two
    /// possible
    /// values: `IMPORTED` or `PENDING_IMPORT`. This field is only present for
    /// symmetric encryption KMS keys with `EXTERNAL` origin.
    import_state: ?ImportState,

    /// Unique identifier of the key.
    key_id: ?[]const u8,

    /// User-specified description of the key material. This field is only present
    /// for symmetric
    /// encryption KMS keys with `EXTERNAL` origin.
    key_material_description: ?[]const u8,

    /// Unique identifier of the key material.
    key_material_id: ?[]const u8,

    /// There are four possible values for this field: `CURRENT`,
    /// `NON_CURRENT`, `PENDING_MULTI_REGION_IMPORT_AND_ROTATION` and
    /// `PENDING_ROTATION`. KMS uses `CURRENT`
    /// key material for both encryption and decryption and `NON_CURRENT` key
    /// material only
    /// for decryption. `PENDING_ROTATION` identifies key material that has been
    /// imported
    /// for on-demand key rotation but the rotation hasn't completed. The key
    /// material state
    /// `PENDING_MULTI_REGION_IMPORT_AND_ROTATION` is unique to multi-region,
    /// symmetric encryption keys with imported key material. It indicates key
    /// material that has
    /// been imported into the primary Region key but not all of the replica Region
    /// keys. When this key material
    /// is imported in to all of the replica Region keys, the key material state
    /// will change to
    /// `PENDING_ROTATION`. Key material in
    /// `PENDING_MULTI_REGION_IMPORT_AND_ROTATION`
    /// or `PENDING_ROTATION` state is not permanently associated with the KMS key.
    /// You can delete
    /// this key material and import different key material in its place. The
    /// `PENDING_MULTI_REGION_IMPORT_AND_ROTATION`
    /// and `PENDING_ROTATION` values are only used in symmetric encryption keys
    /// with imported
    /// key material. The other values, `CURRENT` and `NON_CURRENT`, are used
    /// for all KMS keys that support automatic or on-demand key rotation.
    key_material_state: ?KeyMaterialState,

    /// Date and time that the key material rotation completed. Formatted as Unix
    /// time. This field
    /// is not present for the first key material or an imported key material in
    /// `PENDING_ROTATION` state.
    rotation_date: ?i64,

    /// Identifies whether the key material rotation was a scheduled [automatic
    /// rotation](https://docs.aws.amazon.com/kms/latest/developerguide/rotating-keys-enable-disable.html) or an [on-demand
    /// rotation](https://docs.aws.amazon.com/kms/latest/developerguide/rotating-keys-on-demand.html). This field is not present for the first key material or an imported key
    /// material in `PENDING_ROTATION` state.
    rotation_type: ?RotationType,

    /// Date and time at which the key material expires. This field is only present
    /// for symmetric
    /// encryption KMS keys with `EXTERNAL` origin in rotation list entries with an
    /// `ExpirationModel` value of `KEY_MATERIAL_EXPIRES`.
    valid_to: ?i64,

    pub const json_field_names = .{
        .expiration_model = "ExpirationModel",
        .import_state = "ImportState",
        .key_id = "KeyId",
        .key_material_description = "KeyMaterialDescription",
        .key_material_id = "KeyMaterialId",
        .key_material_state = "KeyMaterialState",
        .rotation_date = "RotationDate",
        .rotation_type = "RotationType",
        .valid_to = "ValidTo",
    };
};
