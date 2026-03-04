const aws = @import("aws");
const std = @import("std");

const add_key_replication_regions = @import("add_key_replication_regions.zig");
const create_alias = @import("create_alias.zig");
const create_key = @import("create_key.zig");
const delete_alias = @import("delete_alias.zig");
const delete_key = @import("delete_key.zig");
const disable_default_key_replication_regions = @import("disable_default_key_replication_regions.zig");
const enable_default_key_replication_regions = @import("enable_default_key_replication_regions.zig");
const export_key = @import("export_key.zig");
const get_alias = @import("get_alias.zig");
const get_certificate_signing_request = @import("get_certificate_signing_request.zig");
const get_default_key_replication_regions = @import("get_default_key_replication_regions.zig");
const get_key = @import("get_key.zig");
const get_parameters_for_export = @import("get_parameters_for_export.zig");
const get_parameters_for_import = @import("get_parameters_for_import.zig");
const get_public_key_certificate = @import("get_public_key_certificate.zig");
const import_key = @import("import_key.zig");
const list_aliases = @import("list_aliases.zig");
const list_keys = @import("list_keys.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const remove_key_replication_regions = @import("remove_key_replication_regions.zig");
const restore_key = @import("restore_key.zig");
const start_key_usage = @import("start_key_usage.zig");
const stop_key_usage = @import("stop_key_usage.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_alias = @import("update_alias.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Payment Cryptography";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds replication Amazon Web Services Regions to an existing Amazon Web
    /// Services Payment Cryptography key, enabling the key to be used for
    /// cryptographic operations in additional Amazon Web Services Regions.
    ///
    /// [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html) allow you to use the same key material across multiple Amazon Web Services Regions, providing lower latency for applications distributed across regions. When you add Replication Regions, Amazon Web Services Payment Cryptography securely replicates the key material to the specified Amazon Web Services Regions.
    ///
    /// The key must be in an active state to add Replication Regions. You can add
    /// multiple regions in a single operation, and the key will be available for
    /// use in those regions once replication is complete.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [RemoveKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_RemoveKeyReplicationRegions.html)
    /// *
    ///   [EnableDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_EnableDefaultKeyReplicationRegions.html)
    /// *
    ///   [GetDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetDefaultKeyReplicationRegions.html)
    pub fn addKeyReplicationRegions(self: *Self, allocator: std.mem.Allocator, input: add_key_replication_regions.AddKeyReplicationRegionsInput, options: CallOptions) !add_key_replication_regions.AddKeyReplicationRegionsOutput {
        return add_key_replication_regions.execute(self, allocator, input, options);
    }

    /// Creates an *alias*, or a friendly name, for an Amazon Web Services Payment
    /// Cryptography key. You can use an alias to identify a key in the console and
    /// when you call cryptographic operations such as
    /// [EncryptData](https://docs.aws.amazon.com/payment-cryptography/latest/DataAPIReference/API_EncryptData.html) or [DecryptData](https://docs.aws.amazon.com/payment-cryptography/latest/DataAPIReference/API_DecryptData.html).
    ///
    /// You can associate the alias with any key in the same Amazon Web Services
    /// Region. Each alias is associated with only one key at a time, but a key can
    /// have multiple aliases. You can't create an alias without a key. The alias
    /// must be unique in the account and Amazon Web Services Region, but you can
    /// create another alias with the same name in a different Amazon Web Services
    /// Region.
    ///
    /// To change the key that's associated with the alias, call
    /// [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html). To delete the alias, call [DeleteAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteAlias.html). These operations don't affect the underlying key. To get the alias that you created, call [ListAliases](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListAliases.html).
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [DeleteAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteAlias.html)
    /// *
    ///   [GetAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetAlias.html)
    /// *
    ///   [ListAliases](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListAliases.html)
    /// *
    ///   [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html)
    pub fn createAlias(self: *Self, allocator: std.mem.Allocator, input: create_alias.CreateAliasInput, options: CallOptions) !create_alias.CreateAliasOutput {
        return create_alias.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services Payment Cryptography key, a logical
    /// representation of a cryptographic key, that is unique in your account and
    /// Amazon Web Services Region. You use keys for cryptographic functions such as
    /// encryption and decryption.
    ///
    /// In addition to the key material used in cryptographic operations, an Amazon
    /// Web Services Payment Cryptography key includes metadata such as the key ARN,
    /// key usage, key origin, creation date, description, and key state.
    ///
    /// When you create a key, you specify both immutable and mutable data about the
    /// key. The immutable data contains key attributes that define the scope and
    /// cryptographic operations that you can perform using the key, for example key
    /// class (example: `SYMMETRIC_KEY`), key algorithm (example: `TDES_2KEY`), key
    /// usage (example: `TR31_P0_PIN_ENCRYPTION_KEY`) and key modes of use (example:
    /// `Encrypt`). Amazon Web Services Payment Cryptography binds key attributes to
    /// keys using key blocks when you store or export them. Amazon Web Services
    /// Payment Cryptography stores the key contents wrapped and never stores or
    /// transmits them in the clear.
    ///
    /// For information about valid combinations of key attributes, see
    /// [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) in the *Amazon Web Services Payment Cryptography User Guide*. The mutable data contained within a key includes usage timestamp and key deletion timestamp and can be modified after creation.
    ///
    /// You can use the `CreateKey` operation to generate an ECC (Elliptic Curve
    /// Cryptography) key pair used for establishing an ECDH (Elliptic Curve
    /// Diffie-Hellman) key agreement between two parties. In the ECDH key agreement
    /// process, both parties generate their own ECC key pair with key usage K3 and
    /// exchange the public keys. Each party then use their private key, the
    /// received public key from the other party, and the key derivation parameters
    /// including key derivation function, hash algorithm, derivation data, and key
    /// algorithm to derive a shared key.
    ///
    /// To maintain the single-use principle of cryptographic keys in payments, ECDH
    /// derived keys should not be used for multiple purposes, such as a
    /// `TR31_P0_PIN_ENCRYPTION_KEY` and `TR31_K1_KEY_BLOCK_PROTECTION_KEY`. When
    /// creating ECC key pairs in Amazon Web Services Payment Cryptography you can
    /// optionally set the `DeriveKeyUsage` parameter, which defines the key usage
    /// bound to the symmetric key that will be derived using the ECC key pair.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [DeleteKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteKey.html)
    /// *
    ///   [GetKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetKey.html)
    /// *
    ///   [ListKeys](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListKeys.html)
    pub fn createKey(self: *Self, allocator: std.mem.Allocator, input: create_key.CreateKeyInput, options: CallOptions) !create_key.CreateKeyOutput {
        return create_key.execute(self, allocator, input, options);
    }

    /// Deletes the alias, but doesn't affect the underlying key.
    ///
    /// Each key can have multiple aliases. To get the aliases of all keys, use the
    /// [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html) operation. To change the alias of a key, first use [DeleteAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteAlias.html) to delete the current alias and then use [CreateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateAlias.html) to create a new alias. To associate an existing alias with a different key, call [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html).
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateAlias.html)
    /// *
    ///   [GetAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetAlias.html)
    /// *
    ///   [ListAliases](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListAliases.html)
    /// *
    ///   [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html)
    pub fn deleteAlias(self: *Self, allocator: std.mem.Allocator, input: delete_alias.DeleteAliasInput, options: CallOptions) !delete_alias.DeleteAliasOutput {
        return delete_alias.execute(self, allocator, input, options);
    }

    /// Deletes the key material and metadata associated with Amazon Web Services
    /// Payment Cryptography key.
    ///
    /// Key deletion is irreversible. After a key is deleted, you can't perform
    /// cryptographic operations using the key. For example, you can't decrypt data
    /// that was encrypted by a deleted Amazon Web Services Payment Cryptography
    /// key, and the data may become unrecoverable. Because key deletion is
    /// destructive, Amazon Web Services Payment Cryptography has a safety mechanism
    /// to prevent accidental deletion of a key. When you call this operation,
    /// Amazon Web Services Payment Cryptography disables the specified key but
    /// doesn't delete it until after a waiting period set using `DeleteKeyInDays`.
    /// The default waiting period is 7 days. During the waiting period, the
    /// `KeyState` is `DELETE_PENDING`. After the key is deleted, the `KeyState` is
    /// `DELETE_COMPLETE`.
    ///
    /// You should delete a key only when you are sure that you don't need to use it
    /// anymore and no other parties are utilizing this key. If you aren't sure,
    /// consider deactivating it instead by calling
    /// [StopKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StopKeyUsage.html).
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [RestoreKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_RestoreKey.html)
    /// *
    ///   [StartKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StartKeyUsage.html)
    /// *
    ///   [StopKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StopKeyUsage.html)
    pub fn deleteKey(self: *Self, allocator: std.mem.Allocator, input: delete_key.DeleteKeyInput, options: CallOptions) !delete_key.DeleteKeyOutput {
        return delete_key.execute(self, allocator, input, options);
    }

    /// Disables [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html) settings for the specified Amazon Web Services Regions in your Amazon Web Services account, preventing new keys from being automatically replicated to those regions.
    ///
    /// After disabling Multi-Region key replication for specific regions, new keys
    /// created in your account will not be automatically replicated to those
    /// regions. You can still manually add replication to those regions for
    /// individual keys using the
    /// [AddKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_AddKeyReplicationRegions.html) operation.
    ///
    /// This operation does not affect existing keys or their current replication
    /// configuration.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [EnableDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_EnableDefaultKeyReplicationRegions.html)
    /// *
    ///   [GetDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetDefaultKeyReplicationRegions.html)
    pub fn disableDefaultKeyReplicationRegions(self: *Self, allocator: std.mem.Allocator, input: disable_default_key_replication_regions.DisableDefaultKeyReplicationRegionsInput, options: CallOptions) !disable_default_key_replication_regions.DisableDefaultKeyReplicationRegionsOutput {
        return disable_default_key_replication_regions.execute(self, allocator, input, options);
    }

    /// Enables [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html) settings for your Amazon Web Services account, causing new keys to be automatically replicated to the specified Amazon Web Services Regions when created.
    ///
    /// When Multi-Region key replication are enabled, any new keys created in your
    /// account will automatically be replicated to these regions unless you
    /// explicitly override this behavior during key creation. This simplifies key
    /// management for applications that operate across multiple regions.
    ///
    /// Existing keys are not affected by this operation - only keys created after
    /// enabling default replication will be automatically replicated.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [DisableDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DisableDefaultKeyReplicationRegions.html)
    /// *
    ///   [GetDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetDefaultKeyReplicationRegions.html)
    pub fn enableDefaultKeyReplicationRegions(self: *Self, allocator: std.mem.Allocator, input: enable_default_key_replication_regions.EnableDefaultKeyReplicationRegionsInput, options: CallOptions) !enable_default_key_replication_regions.EnableDefaultKeyReplicationRegionsOutput {
        return enable_default_key_replication_regions.execute(self, allocator, input, options);
    }

    /// Exports a key from Amazon Web Services Payment Cryptography.
    ///
    /// Amazon Web Services Payment Cryptography simplifies key exchange by
    /// replacing the existing paper-based approach with a modern electronic
    /// approach. With `ExportKey` you can export symmetric keys using either
    /// symmetric and asymmetric key exchange mechanisms. Using this operation, you
    /// can share your Amazon Web Services Payment Cryptography generated keys with
    /// other service partners to perform cryptographic operations outside of Amazon
    /// Web Services Payment Cryptography
    ///
    /// For symmetric key exchange, Amazon Web Services Payment Cryptography uses
    /// the ANSI X9 TR-31 norm in accordance with PCI PIN guidelines. And for
    /// asymmetric key exchange, Amazon Web Services Payment Cryptography supports
    /// ANSI X9 TR-34 norm, RSA unwrap, and ECDH (Elliptic Curve Diffie-Hellman) key
    /// exchange mechanisms. Asymmetric key exchange methods are typically used to
    /// establish bi-directional trust between the two parties exhanging keys and
    /// are used for initial key exchange such as Key Encryption Key (KEK). After
    /// which you can export working keys using symmetric method to perform various
    /// cryptographic operations within Amazon Web Services Payment Cryptography.
    ///
    /// PCI requires specific minimum key strength of wrapping keys used to protect
    /// the keys being exchanged electronically. These requirements can change when
    /// PCI standards are revised. The rules specify that wrapping keys used for
    /// transport must be at least as strong as the key being protected. For more
    /// information on recommended key strength of wrapping keys and key exchange
    /// mechanism, see [Importing and exporting
    /// keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-importexport.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// You can also use `ExportKey` functionality to generate and export an IPEK
    /// (Initial Pin Encryption Key) from Amazon Web Services Payment Cryptography
    /// using either TR-31 or TR-34 export key exchange. IPEK is generated from BDK
    /// (Base Derivation Key) and `ExportDukptInitialKey` attribute KSN
    /// (`KeySerialNumber`). The generated IPEK does not persist within Amazon Web
    /// Services Payment Cryptography and has to be re-generated each time during
    /// export.
    ///
    /// For key exchange using TR-31 or TR-34 key blocks, you can also export
    /// optional blocks within the key block header which contain additional
    /// attribute information about the key. The `KeyVersion` within
    /// `KeyBlockHeaders` indicates the version of the key within the key block.
    /// Furthermore, `KeyExportability` within `KeyBlockHeaders` can be used to
    /// further restrict exportability of the key after export from Amazon Web
    /// Services Payment Cryptography.
    ///
    /// The `OptionalBlocks` contain the additional data related to the key. For
    /// information on data type that can be included within optional blocks, refer
    /// to [ASC
    /// X9.143-2022](https://webstore.ansi.org/standards/ascx9/ansix91432022).
    ///
    /// Data included in key block headers is signed but transmitted in clear text.
    /// Sensitive or confidential information should not be included in optional
    /// blocks. Refer to ASC X9.143-2022 standard for information on allowed data
    /// type.
    ///
    /// **To export initial keys (KEK) or IPEK using TR-34**
    ///
    /// Using this operation, you can export initial key using TR-34 asymmetric key
    /// exchange. You can only export KEK generated within Amazon Web Services
    /// Payment Cryptography. In TR-34 terminology, the sending party of the key is
    /// called Key Distribution Host (KDH) and the receiving party of the key is
    /// called Key Receiving Device (KRD). During key export process, KDH is Amazon
    /// Web Services Payment Cryptography which initiates key export and KRD is the
    /// user receiving the key.
    ///
    /// To initiate TR-34 key export, the KRD must obtain an export token by calling
    /// [GetParametersForExport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForExport.html). This operation also generates a key pair for the purpose of key export, signs the key and returns back the signing public key certificate (also known as KDH signing certificate) and root certificate chain. The KDH uses the private key to sign the the export payload and the signing public key certificate is provided to KRD to verify the signature. The KRD can import the root certificate into its Hardware Security Module (HSM), as required. The export token and the associated KDH signing certificate expires after 30 days.
    ///
    /// Next the KRD generates a key pair for the the purpose of encrypting the KDH
    /// key and provides the public key cerificate (also known as KRD wrapping
    /// certificate) back to KDH. The KRD will also import the root cerificate chain
    /// into Amazon Web Services Payment Cryptography by calling
    /// [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html) for `RootCertificatePublicKey`. The KDH, Amazon Web Services Payment Cryptography, will use the KRD wrapping cerificate to encrypt (wrap) the key under export and signs it with signing private key to generate a TR-34 WrappedKeyBlock. For more information on TR-34 key export, see section [Exporting symmetric keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-export.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// Set the following parameters:
    ///
    /// * `ExportAttributes`: Specify export attributes in case of IPEK export. This
    ///   parameter is optional for KEK export.
    /// * `ExportKeyIdentifier`: The `KeyARN` of the KEK or BDK (in case of IPEK)
    ///   under export.
    /// * `KeyMaterial`: Use `Tr34KeyBlock` parameters.
    /// * `CertificateAuthorityPublicKeyIdentifier`: The `KeyARN` of the certificate
    ///   chain that signed the KRD wrapping key certificate.
    /// * `ExportToken`: Obtained from KDH by calling
    ///   [GetParametersForImport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForImport.html).
    /// * `WrappingKeyCertificate`: The public key certificate in PEM format (base64
    ///   encoded) of the KRD wrapping key Amazon Web Services Payment Cryptography
    ///   uses for encryption of the TR-34 export payload. This certificate must be
    ///   signed by the root certificate (CertificateAuthorityPublicKeyIdentifier)
    ///   imported into Amazon Web Services Payment Cryptography.
    ///
    /// When this operation is successful, Amazon Web Services Payment Cryptography
    /// returns the KEK or IPEK as a TR-34 WrappedKeyBlock.
    ///
    /// **To export initial keys (KEK) or IPEK using RSA Wrap and Unwrap**
    ///
    /// Using this operation, you can export initial key using asymmetric RSA wrap
    /// and unwrap key exchange method. To initiate export, generate an asymmetric
    /// key pair on the receiving HSM and obtain the public key certificate in PEM
    /// format (base64 encoded) for the purpose of wrapping and the root certifiate
    /// chain. Import the root certificate into Amazon Web Services Payment
    /// Cryptography by calling
    /// [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html) for `RootCertificatePublicKey`.
    ///
    /// Next call `ExportKey` and set the following parameters:
    ///
    /// * `CertificateAuthorityPublicKeyIdentifier`: The `KeyARN` of the certificate
    ///   chain that signed wrapping key certificate.
    /// * `KeyMaterial`: Set to `KeyCryptogram`.
    /// * `WrappingKeyCertificate`: The public key certificate in PEM format (base64
    ///   encoded) obtained by the receiving HSM and signed by the root certificate
    ///   (CertificateAuthorityPublicKeyIdentifier) imported into Amazon Web
    ///   Services Payment Cryptography. The receiving HSM uses its private key
    ///   component to unwrap the WrappedKeyCryptogram.
    ///
    /// When this operation is successful, Amazon Web Services Payment Cryptography
    /// returns the WrappedKeyCryptogram.
    ///
    /// **To export working keys or IPEK using TR-31**
    ///
    /// Using this operation, you can export working keys or IPEK using TR-31
    /// symmetric key exchange. In TR-31, you must use an initial key such as KEK to
    /// encrypt or wrap the key under export. To establish a KEK, you can use
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html) or [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html).
    ///
    /// Set the following parameters:
    ///
    /// * `ExportAttributes`: Specify export attributes in case of IPEK export. This
    ///   parameter is optional for KEK export.
    /// * `ExportKeyIdentifier`: The `KeyARN` of the KEK or BDK (in case of IPEK)
    ///   under export.
    /// * `KeyMaterial`: Use `Tr31KeyBlock` parameters.
    ///
    /// **To export working keys using ECDH**
    ///
    /// You can also use ECDH key agreement to export working keys in a TR-31
    /// keyblock, where the wrapping key is an ECDH derived key.
    ///
    /// To initiate a TR-31 key export using ECDH, both sides must create an ECC key
    /// pair with key usage K3 and exchange public key certificates. In Amazon Web
    /// Services Payment Cryptography, you can do this by calling `CreateKey`. If
    /// you have not already done so, you must import the CA chain that issued the
    /// receiving public key certificate by calling `ImportKey` with input
    /// `RootCertificatePublicKey` for root CA or `TrustedPublicKey` for
    /// intermediate CA. You can then complete a TR-31 key export by deriving a
    /// shared wrapping key using the service ECC key pair, public certificate of
    /// your ECC key pair outside of Amazon Web Services Payment Cryptography, and
    /// the key derivation parameters including key derivation function, hash
    /// algorithm, derivation data, key algorithm.
    ///
    /// * `KeyMaterial`: Use `DiffieHellmanTr31KeyBlock` parameters.
    /// * `PrivateKeyIdentifier`: The `KeyArn` of the ECC key pair created within
    ///   Amazon Web Services Payment Cryptography to derive a shared KEK.
    /// * `PublicKeyCertificate`: The public key certificate of the receiving ECC
    ///   key pair in PEM format (base64 encoded) to derive a shared KEK.
    /// * `CertificateAuthorityPublicKeyIdentifier`: The `keyARN` of the CA that
    ///   signed the public key certificate of the receiving ECC key pair.
    ///
    /// When this operation is successful, Amazon Web Services Payment Cryptography
    /// returns the working key as a TR-31 WrappedKeyBlock, where the wrapping key
    /// is the ECDH derived key.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [GetParametersForExport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForExport.html)
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    pub fn exportKey(self: *Self, allocator: std.mem.Allocator, input: export_key.ExportKeyInput, options: CallOptions) !export_key.ExportKeyOutput {
        return export_key.execute(self, allocator, input, options);
    }

    /// Gets the Amazon Web Services Payment Cryptography key associated with the
    /// alias.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateAlias.html)
    /// *
    ///   [DeleteAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteAlias.html)
    /// *
    ///   [ListAliases](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListAliases.html)
    /// *
    ///   [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html)
    pub fn getAlias(self: *Self, allocator: std.mem.Allocator, input: get_alias.GetAliasInput, options: CallOptions) !get_alias.GetAliasOutput {
        return get_alias.execute(self, allocator, input, options);
    }

    /// Creates a certificate signing request (CSR) from a key pair.
    pub fn getCertificateSigningRequest(self: *Self, allocator: std.mem.Allocator, input: get_certificate_signing_request.GetCertificateSigningRequestInput, options: CallOptions) !get_certificate_signing_request.GetCertificateSigningRequestOutput {
        return get_certificate_signing_request.execute(self, allocator, input, options);
    }

    /// Retrieves the list of Amazon Web Services Regions where [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html) is currently enabled for your Amazon Web Services account.
    ///
    /// This operation returns the current Multi-Region key replication
    /// configuration. New keys created in your account will be automatically
    /// replicated to these regions unless explicitly overridden during key
    /// creation.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [EnableDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_EnableDefaultKeyReplicationRegions.html)
    /// *
    ///   [DisableDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DisableDefaultKeyReplicationRegions.html)
    pub fn getDefaultKeyReplicationRegions(self: *Self, allocator: std.mem.Allocator, input: get_default_key_replication_regions.GetDefaultKeyReplicationRegionsInput, options: CallOptions) !get_default_key_replication_regions.GetDefaultKeyReplicationRegionsOutput {
        return get_default_key_replication_regions.execute(self, allocator, input, options);
    }

    /// Gets the key metadata for an Amazon Web Services Payment Cryptography key,
    /// including the immutable and mutable attributes specified when the key was
    /// created. Returns key metadata including attributes, state, and timestamps,
    /// but does not return the actual cryptographic key material.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html)
    /// *
    ///   [DeleteKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteKey.html)
    /// *
    ///   [ListKeys](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListKeys.html)
    pub fn getKey(self: *Self, allocator: std.mem.Allocator, input: get_key.GetKeyInput, options: CallOptions) !get_key.GetKeyOutput {
        return get_key.execute(self, allocator, input, options);
    }

    /// Gets the export token and the signing key certificate to initiate a TR-34
    /// key export from Amazon Web Services Payment Cryptography.
    ///
    /// The signing key certificate signs the wrapped key under export within the
    /// TR-34 key payload. The export token and signing key certificate must be in
    /// place and operational before calling
    /// [ExportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ExportKey.html). The export token expires in 30 days. You can use the same export token to export multiple keys from your service account.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [ExportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ExportKey.html)
    /// *
    ///   [GetParametersForImport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForImport.html)
    pub fn getParametersForExport(self: *Self, allocator: std.mem.Allocator, input: get_parameters_for_export.GetParametersForExportInput, options: CallOptions) !get_parameters_for_export.GetParametersForExportOutput {
        return get_parameters_for_export.execute(self, allocator, input, options);
    }

    /// Gets the import token and the wrapping key certificate in PEM format (base64
    /// encoded) to initiate a TR-34 WrappedKeyBlock or a RSA WrappedKeyCryptogram
    /// import into Amazon Web Services Payment Cryptography.
    ///
    /// The wrapping key certificate wraps the key under import. The import token
    /// and wrapping key certificate must be in place and operational before calling
    /// [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html). The import token expires in 30 days. You can use the same import token to import multiple keys into your service account.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [GetParametersForExport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForExport.html)
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    pub fn getParametersForImport(self: *Self, allocator: std.mem.Allocator, input: get_parameters_for_import.GetParametersForImportInput, options: CallOptions) !get_parameters_for_import.GetParametersForImportOutput {
        return get_parameters_for_import.execute(self, allocator, input, options);
    }

    /// Gets the public key certificate of the asymmetric key pair that exists
    /// within Amazon Web Services Payment Cryptography.
    ///
    /// Unlike the private key of an asymmetric key, which never leaves Amazon Web
    /// Services Payment Cryptography unencrypted, callers with
    /// `GetPublicKeyCertificate` permission can download the public key certificate
    /// of the asymmetric key. You can share the public key certificate to allow
    /// others to encrypt messages and verify signatures outside of Amazon Web
    /// Services Payment Cryptography
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    pub fn getPublicKeyCertificate(self: *Self, allocator: std.mem.Allocator, input: get_public_key_certificate.GetPublicKeyCertificateInput, options: CallOptions) !get_public_key_certificate.GetPublicKeyCertificateOutput {
        return get_public_key_certificate.execute(self, allocator, input, options);
    }

    /// Imports symmetric keys and public key certificates in PEM format (base64
    /// encoded) into Amazon Web Services Payment Cryptography.
    ///
    /// Amazon Web Services Payment Cryptography simplifies key exchange by
    /// replacing the existing paper-based approach with a modern electronic
    /// approach. With `ImportKey` you can import symmetric keys using either
    /// symmetric and asymmetric key exchange mechanisms.
    ///
    /// For symmetric key exchange, Amazon Web Services Payment Cryptography uses
    /// the ANSI X9 TR-31 norm in accordance with PCI PIN guidelines. And for
    /// asymmetric key exchange, Amazon Web Services Payment Cryptography supports
    /// ANSI X9 TR-34 norm, RSA unwrap, and ECDH (Elliptic Curve Diffie-Hellman) key
    /// exchange mechanisms. Asymmetric key exchange methods are typically used to
    /// establish bi-directional trust between the two parties exhanging keys and
    /// are used for initial key exchange such as Key Encryption Key (KEK) or Zone
    /// Master Key (ZMK). After which you can import working keys using symmetric
    /// method to perform various cryptographic operations within Amazon Web
    /// Services Payment Cryptography.
    ///
    /// PCI requires specific minimum key strength of wrapping keys used to protect
    /// the keys being exchanged electronically. These requirements can change when
    /// PCI standards are revised. The rules specify that wrapping keys used for
    /// transport must be at least as strong as the key being protected. For more
    /// information on recommended key strength of wrapping keys and key exchange
    /// mechanism, see [Importing and exporting
    /// keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-importexport.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// You can also import a *root public key certificate*, used to sign other
    /// public key certificates, or a *trusted public key certificate* under an
    /// already established root public key certificate.
    ///
    /// **To import a public root key certificate**
    ///
    /// Using this operation, you can import the public component (in PEM cerificate
    /// format) of your private root key. You can use the imported public root key
    /// certificate for digital signatures, for example signing wrapping key or
    /// signing key in TR-34, within your Amazon Web Services Payment Cryptography
    /// account.
    ///
    /// Set the following parameters:
    ///
    /// * `KeyMaterial`: `RootCertificatePublicKey`
    /// * `KeyClass`: `PUBLIC_KEY`
    /// * `KeyModesOfUse`: `Verify`
    /// * `KeyUsage`: `TR31_S0_ASYMMETRIC_KEY_FOR_DIGITAL_SIGNATURE`
    /// * `PublicKeyCertificate`: The public key certificate in PEM format (base64
    ///   encoded) of the private root key under import.
    ///
    /// **To import a trusted public key certificate**
    ///
    /// The root public key certificate must be in place and operational before you
    /// import a trusted public key certificate. Set the following parameters:
    ///
    /// * `KeyMaterial`: `TrustedCertificatePublicKey`
    /// * `CertificateAuthorityPublicKeyIdentifier`: `KeyArn` of the
    ///   `RootCertificatePublicKey`.
    /// * `KeyModesOfUse` and `KeyUsage`: Corresponding to the cryptographic
    ///   operations such as wrap, sign, or encrypt that you will allow the trusted
    ///   public key certificate to perform.
    /// * `PublicKeyCertificate`: The trusted public key certificate in PEM format
    ///   (base64 encoded) under import.
    ///
    /// **To import initial keys (KEK or ZMK or similar) using TR-34**
    ///
    /// Using this operation, you can import initial key using TR-34 asymmetric key
    /// exchange. In TR-34 terminology, the sending party of the key is called Key
    /// Distribution Host (KDH) and the receiving party of the key is called Key
    /// Receiving Device (KRD). During the key import process, KDH is the user who
    /// initiates the key import and KRD is Amazon Web Services Payment Cryptography
    /// who receives the key.
    ///
    /// To initiate TR-34 key import, the KDH must obtain an import token by calling
    /// [GetParametersForImport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForImport.html). This operation generates an encryption keypair for the purpose of key import, signs the key and returns back the wrapping key certificate (also known as KRD wrapping certificate) and the root certificate chain. The KDH must trust and install the KRD wrapping certificate on its HSM and use it to encrypt (wrap) the KDH key during TR-34 WrappedKeyBlock generation. The import token and associated KRD wrapping certificate expires after 30 days.
    ///
    /// Next the KDH generates a key pair for the purpose of signing the encrypted
    /// KDH key and provides the public certificate of the signing key to Amazon Web
    /// Services Payment Cryptography. The KDH will also need to import the root
    /// certificate chain of the KDH signing certificate by calling `ImportKey` for
    /// `RootCertificatePublicKey`. For more information on TR-34 key import, see
    /// section [Importing symmetric
    /// keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-import.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// Set the following parameters:
    ///
    /// * `KeyMaterial`: Use `Tr34KeyBlock` parameters.
    /// * `CertificateAuthorityPublicKeyIdentifier`: The `KeyARN` of the certificate
    ///   chain that signed the KDH signing key certificate.
    /// * `ImportToken`: Obtained from KRD by calling
    ///   [GetParametersForImport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForImport.html).
    /// * `WrappedKeyBlock`: The TR-34 wrapped key material from KDH. It contains
    ///   the KDH key under import, wrapped with KRD wrapping certificate and signed
    ///   by KDH signing private key. This TR-34 key block is typically generated by
    ///   the KDH Hardware Security Module (HSM) outside of Amazon Web Services
    ///   Payment Cryptography.
    /// * `SigningKeyCertificate`: The public key certificate in PEM format (base64
    ///   encoded) of the KDH signing key generated under the root certificate
    ///   (CertificateAuthorityPublicKeyIdentifier) imported in Amazon Web Services
    ///   Payment Cryptography.
    ///
    /// **To import initial keys (KEK or ZMK or similar) using RSA Wrap and Unwrap**
    ///
    /// Using this operation, you can import initial key using asymmetric RSA wrap
    /// and unwrap key exchange method. To initiate import, call
    /// [GetParametersForImport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForImport.html) with `KeyMaterial` set to `KEY_CRYPTOGRAM` to generate an import token. This operation also generates an encryption keypair for the purpose of key import, signs the key and returns back the wrapping key certificate in PEM format (base64 encoded) and its root certificate chain. The import token and associated KRD wrapping certificate expires after 30 days.
    ///
    /// You must trust and install the wrapping certificate and its certificate
    /// chain on the sending HSM and use it to wrap the key under export for
    /// WrappedKeyCryptogram generation. Next call `ImportKey` with `KeyMaterial`
    /// set to `KEY_CRYPTOGRAM` and provide the `ImportToken` and `KeyAttributes`
    /// for the key under import.
    ///
    /// **To import working keys using TR-31**
    ///
    /// Amazon Web Services Payment Cryptography uses TR-31 symmetric key exchange
    /// norm to import working keys. A KEK must be established within Amazon Web
    /// Services Payment Cryptography by using TR-34 key import or by using
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html). To initiate a TR-31 key import, set the following parameters:
    ///
    /// * `KeyMaterial`: Use `Tr31KeyBlock` parameters.
    /// * `WrappedKeyBlock`: The TR-31 wrapped key material. It contains the key
    ///   under import, encrypted using KEK. The TR-31 key block is typically
    ///   generated by a HSM outside of Amazon Web Services Payment Cryptography.
    /// * `WrappingKeyIdentifier`: The `KeyArn` of the KEK that Amazon Web Services
    ///   Payment Cryptography uses to decrypt or unwrap the key under import.
    ///
    /// **To import working keys using ECDH**
    ///
    /// You can also use ECDH key agreement to import working keys as a TR-31
    /// keyblock, where the wrapping key is an ECDH derived key.
    ///
    /// To initiate a TR-31 key import using ECDH, both sides must create an ECC key
    /// pair with key usage K3 and exchange public key certificates. In Amazon Web
    /// Services Payment Cryptography, you can do this by calling `CreateKey` and
    /// then `GetPublicKeyCertificate` to retrieve its public key certificate. Next,
    /// you can then generate a TR-31 WrappedKeyBlock using your own ECC key pair,
    /// the public certificate of the service's ECC key pair, and the key derivation
    /// parameters including key derivation function, hash algorithm, derivation
    /// data, and key algorithm. If you have not already done so, you must import
    /// the CA chain that issued the receiving public key certificate by calling
    /// `ImportKey` with input `RootCertificatePublicKey` for root CA or
    /// `TrustedPublicKey` for intermediate CA. To complete the TR-31 key import,
    /// you can use the following parameters. It is important that the ECDH key
    /// derivation parameters you use should match those used during import to
    /// derive the same shared wrapping key within Amazon Web Services Payment
    /// Cryptography.
    ///
    /// * `KeyMaterial`: Use `DiffieHellmanTr31KeyBlock` parameters.
    /// * `PrivateKeyIdentifier`: The `KeyArn` of the ECC key pair created within
    ///   Amazon Web Services Payment Cryptography to derive a shared KEK.
    /// * `PublicKeyCertificate`: The public key certificate of the receiving ECC
    ///   key pair in PEM format (base64 encoded) to derive a shared KEK.
    /// * `CertificateAuthorityPublicKeyIdentifier`: The `keyARN` of the CA that
    ///   signed the public key certificate of the receiving ECC key pair.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [ExportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ExportKey.html)
    /// *
    ///   [GetParametersForImport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForImport.html)
    pub fn importKey(self: *Self, allocator: std.mem.Allocator, input: import_key.ImportKeyInput, options: CallOptions) !import_key.ImportKeyOutput {
        return import_key.execute(self, allocator, input, options);
    }

    /// Lists the aliases for all keys in the caller's Amazon Web Services account
    /// and Amazon Web Services Region. You can filter the aliases by `keyARN`. For
    /// more information, see [Using
    /// aliases](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-managealias.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// This is a paginated operation, which means that each response might contain
    /// only a subset of all the aliases. When the response contains only a subset
    /// of aliases, it includes a `NextToken` value. Use this value in a subsequent
    /// `ListAliases` request to get more aliases. When you receive a response with
    /// no NextToken (or an empty or null value), that means there are no more
    /// aliases to get.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateAlias.html)
    /// *
    ///   [DeleteAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteAlias.html)
    /// *
    ///   [GetAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetAlias.html)
    /// *
    ///   [UpdateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UpdateAlias.html)
    pub fn listAliases(self: *Self, allocator: std.mem.Allocator, input: list_aliases.ListAliasesInput, options: CallOptions) !list_aliases.ListAliasesOutput {
        return list_aliases.execute(self, allocator, input, options);
    }

    /// Lists the keys in the caller's Amazon Web Services account and Amazon Web
    /// Services Region. You can filter the list of keys.
    ///
    /// This is a paginated operation, which means that each response might contain
    /// only a subset of all the keys. When the response contains only a subset of
    /// keys, it includes a `NextToken` value. Use this value in a subsequent
    /// `ListKeys` request to get more keys. When you receive a response with no
    /// NextToken (or an empty or null value), that means there are no more keys to
    /// get.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html)
    /// *
    ///   [DeleteKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteKey.html)
    /// *
    ///   [GetKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetKey.html)
    pub fn listKeys(self: *Self, allocator: std.mem.Allocator, input: list_keys.ListKeysInput, options: CallOptions) !list_keys.ListKeysOutput {
        return list_keys.execute(self, allocator, input, options);
    }

    /// Lists the tags for an Amazon Web Services resource.
    ///
    /// This is a paginated operation, which means that each response might contain
    /// only a subset of all the tags. When the response contains only a subset of
    /// tags, it includes a `NextToken` value. Use this value in a subsequent
    /// `ListTagsForResource` request to get more tags. When you receive a response
    /// with no NextToken (or an empty or null value), that means there are no more
    /// tags to get.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [TagResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_TagResource.html)
    /// *
    ///   [UntagResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UntagResource.html)
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Removes Replication Regions from an existing Amazon Web Services Payment
    /// Cryptography key, disabling the key's availability for cryptographic
    /// operations in the specified Amazon Web Services Regions.
    ///
    /// When you remove Replication Regions, the key material is securely deleted
    /// from those regions and can no longer be used for cryptographic operations
    /// there. This operation is irreversible for the specified Amazon Web Services
    /// Regions. For more information, see [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html).
    ///
    /// Ensure that no active cryptographic operations or applications depend on the
    /// key in the regions you're removing before performing this operation.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [AddKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_AddKeyReplicationRegions.html)
    /// *
    ///   [DisableDefaultKeyReplicationRegions](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DisableDefaultKeyReplicationRegions.html)
    pub fn removeKeyReplicationRegions(self: *Self, allocator: std.mem.Allocator, input: remove_key_replication_regions.RemoveKeyReplicationRegionsInput, options: CallOptions) !remove_key_replication_regions.RemoveKeyReplicationRegionsOutput {
        return remove_key_replication_regions.execute(self, allocator, input, options);
    }

    /// Cancels a scheduled key deletion during the waiting period. Use this
    /// operation to restore a `Key` that is scheduled for deletion.
    ///
    /// During the waiting period, the `KeyState` is `DELETE_PENDING` and
    /// `deletePendingTimestamp` contains the date and time after which the `Key`
    /// will be deleted. After `Key` is restored, the `KeyState` is
    /// `CREATE_COMPLETE`, and the value for `deletePendingTimestamp` is removed.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [DeleteKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteKey.html)
    /// *
    ///   [StartKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StartKeyUsage.html)
    /// *
    ///   [StopKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StopKeyUsage.html)
    pub fn restoreKey(self: *Self, allocator: std.mem.Allocator, input: restore_key.RestoreKeyInput, options: CallOptions) !restore_key.RestoreKeyOutput {
        return restore_key.execute(self, allocator, input, options);
    }

    /// Enables an Amazon Web Services Payment Cryptography key, which makes it
    /// active for cryptographic operations within Amazon Web Services Payment
    /// Cryptography
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [StopKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StopKeyUsage.html)
    pub fn startKeyUsage(self: *Self, allocator: std.mem.Allocator, input: start_key_usage.StartKeyUsageInput, options: CallOptions) !start_key_usage.StartKeyUsageOutput {
        return start_key_usage.execute(self, allocator, input, options);
    }

    /// Disables an Amazon Web Services Payment Cryptography key, which makes it
    /// inactive within Amazon Web Services Payment Cryptography.
    ///
    /// You can use this operation instead of
    /// [DeleteKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteKey.html) to deactivate a key. You can enable the key in the future by calling [StartKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StartKeyUsage.html).
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [DeleteKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteKey.html)
    /// *
    ///   [StartKeyUsage](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_StartKeyUsage.html)
    pub fn stopKeyUsage(self: *Self, allocator: std.mem.Allocator, input: stop_key_usage.StopKeyUsageInput, options: CallOptions) !stop_key_usage.StopKeyUsageOutput {
        return stop_key_usage.execute(self, allocator, input, options);
    }

    /// Adds or edits tags on an Amazon Web Services Payment Cryptography key.
    ///
    /// Tagging or untagging an Amazon Web Services Payment Cryptography key can
    /// allow or deny permission to the key.
    ///
    /// Each tag consists of a tag key and a tag value, both of which are
    /// case-sensitive strings. The tag value can be an empty (null) string. To add
    /// a tag, specify a new tag key and a tag value. To edit a tag, specify an
    /// existing tag key and a new tag value. You can also add tags to an Amazon Web
    /// Services Payment Cryptography key when you create it with
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html).
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [ListTagsForResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListTagsForResource.html)
    /// *
    ///   [UntagResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_UntagResource.html)
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes a tag from an Amazon Web Services Payment Cryptography key.
    ///
    /// Tagging or untagging an Amazon Web Services Payment Cryptography key can
    /// allow or deny permission to the key.
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [ListTagsForResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListTagsForResource.html)
    /// *
    ///   [TagResource](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_TagResource.html)
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Associates an existing Amazon Web Services Payment Cryptography alias with a
    /// different key. Each alias is associated with only one Amazon Web Services
    /// Payment Cryptography key at a time, although a key can have multiple
    /// aliases. The alias and the Amazon Web Services Payment Cryptography key must
    /// be in the same Amazon Web Services account and Amazon Web Services Region
    ///
    /// **Cross-account use:** This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateAlias.html)
    /// *
    ///   [DeleteAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_DeleteAlias.html)
    /// *
    ///   [GetAlias](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetAlias.html)
    /// *
    ///   [ListAliases](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ListAliases.html)
    pub fn updateAlias(self: *Self, allocator: std.mem.Allocator, input: update_alias.UpdateAliasInput, options: CallOptions) !update_alias.UpdateAliasOutput {
        return update_alias.execute(self, allocator, input, options);
    }

    pub fn listAliasesPaginator(self: *Self, params: list_aliases.ListAliasesInput) paginator.ListAliasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKeysPaginator(self: *Self, params: list_keys.ListKeysInput) paginator.ListKeysPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
