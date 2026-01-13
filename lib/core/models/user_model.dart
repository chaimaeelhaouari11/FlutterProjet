/// Modèle représentant un utilisateur de l'application.
/// Ce modèle est utilisé pour stocker les informations de profil, qu'il s'agisse 
/// d'un utilisateur enregistré ou d'un invité (Guest).
class UserModel {
  /// Identifiant unique de l'utilisateur (UID).
  final String id;
  
  /// Nom complet de l'utilisateur.
  final String name;
  
  /// Adresse email utilisée pour le compte.
  final String email;
  
  /// Index de l'avatar sélectionné dans la liste prédéfinie [avatars].
  final int avatarIndex;
  
  /// Chemin optionnel vers une image de profil personnalisée.
  final String? profileImage;
  
  /// Indicateur pour savoir si l'utilisateur utilise l'application sans compte.
  final bool isGuest;
  
  /// Date de création du compte ou de la session.
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarIndex,
    this.profileImage,
    required this.isGuest,
    this.createdAt,
  });

  /// Crée une nouvelle instance de [UserModel] avec certaines propriétés modifiées.
  /// C'est une méthode essentielle pour respecter le principe d'immutabilité :
  /// On ne change pas l'objet existant, on en crée un nouveau avec les modifications.
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? avatarIndex,
    String? profileImage,
    bool? isGuest,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      profileImage: profileImage ?? this.profileImage,
      isGuest: isGuest ?? this.isGuest,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Transforme l'objet en Map pour le stockage (Base de données locale ou SharedPreferences).
  /// Les booléens sont convertis en entiers (1/0) et les dates en chaînes ISO8601.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarIndex': avatarIndex,
      'profileImage': profileImage,
      'isGuest': isGuest ? 1 : 0,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// Recrée un objet [UserModel] à partir d'un Map extrait d'une source de données.
  /// Inclut une gestion robuste des types pour éviter les erreurs lors du parsing.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarIndex: map['avatarIndex'] ?? 0,
      profileImage: map['profileImage'],
      isGuest: map['isGuest'] == 1,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  /// Liste statique d'emojis utilisés comme avatars par défaut.
  /// L'utilisation de 'static const' permet d'optimiser la mémoire car la liste n'est créée qu'une fois.
  static const List<String> avatars = [
    '👤', '👨', '👩', '🧑', '👨‍💻', '👩‍💻', 
    '🧑‍🎓', '👨‍🎓', '👩‍🎓', '🧑‍🏫', '👨‍🏫', '👩‍🏫',
    '🦸', '🦸‍♂️', '🦸‍♀️', '🧙', '🧙‍♂️', '🧙‍♀️',
  ];

  /// Getter calculé pour récupérer l'emoji correspondant à l'index de l'avatar.
  /// Utilise l'opérateur modulo (%) pour éviter les erreurs d'index hors limites.
  String get avatarEmoji => avatars[avatarIndex % avatars.length];
}
