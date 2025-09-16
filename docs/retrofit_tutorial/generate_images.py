#!/usr/bin/env python3
"""
Generate visual assets for Retrofit Flutter Tutorial
Creates LinkedIn-ready images with code examples and infographics
"""

import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np
from PIL import Image, ImageDraw, ImageFont
import io

# Set style
plt.style.use('dark_background')

def create_tutorial_banner():
    """Create main tutorial banner"""
    fig, ax = plt.subplots(figsize=(12, 6))
    fig.patch.set_facecolor('#0D1117')
    ax.set_facecolor('#0D1117')
    
    # Title
    ax.text(0.5, 0.7, 'Retrofit in Flutter', 
            horizontalalignment='center', verticalalignment='center',
            fontsize=40, fontweight='bold', color='#58A6FF')
    
    ax.text(0.5, 0.5, 'Complete Tutorial & Guide', 
            horizontalalignment='center', verticalalignment='center',
            fontsize=24, color='#F0F6FC')
    
    ax.text(0.5, 0.3, 'Type-safe HTTP client • Clean Architecture • Real Examples', 
            horizontalalignment='center', verticalalignment='center',
            fontsize=16, color='#8B949E')
    
    # Add decorative elements
    ax.add_patch(patches.Rectangle((0.1, 0.15), 0.8, 0.05, 
                                 facecolor='#21262D', edgecolor='#30363D'))
    
    # Flutter and Retrofit logos (represented as colored rectangles)
    ax.add_patch(patches.Circle((0.2, 0.1), 0.03, facecolor='#02569B', alpha=0.8))
    ax.text(0.25, 0.1, 'Flutter', verticalalignment='center', color='#02569B', fontweight='bold')
    
    ax.add_patch(patches.Circle((0.7, 0.1), 0.03, facecolor='#48C9B0', alpha=0.8))
    ax.text(0.75, 0.1, 'Retrofit', verticalalignment='center', color='#48C9B0', fontweight='bold')
    
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('/home/runner/work/BocApp/BocApp/docs/retrofit_tutorial/images/retrofit_banner.png', 
                dpi=300, bbox_inches='tight', facecolor='#0D1117')
    plt.close()

def create_architecture_diagram():
    """Create architecture diagram"""
    fig, ax = plt.subplots(figsize=(14, 10))
    fig.patch.set_facecolor('#0D1117')
    ax.set_facecolor('#0D1117')
    
    # Define layers
    layers = [
        {'name': 'UI Layer (Widgets)', 'y': 0.8, 'color': '#58A6FF'},
        {'name': 'BLoC/Cubit (State Management)', 'y': 0.65, 'color': '#F79000'},
        {'name': 'Repository (Business Logic)', 'y': 0.5, 'color': '#3FB950'},
        {'name': 'API Service (Retrofit)', 'y': 0.35, 'color': '#D29922'},
        {'name': 'HTTP Client (Dio)', 'y': 0.2, 'color': '#DA3633'},
    ]
    
    # Draw layers
    for i, layer in enumerate(layers):
        # Main box
        rect = FancyBboxPatch((0.1, layer['y']-0.05), 0.8, 0.08,
                              boxstyle="round,pad=0.01",
                              facecolor=layer['color'], alpha=0.2,
                              edgecolor=layer['color'], linewidth=2)
        ax.add_patch(rect)
        
        # Text
        ax.text(0.5, layer['y'], layer['name'], 
                horizontalalignment='center', verticalalignment='center',
                fontsize=14, fontweight='bold', color=layer['color'])
        
        # Arrow to next layer
        if i < len(layers) - 1:
            ax.arrow(0.5, layer['y']-0.05, 0, -0.05, 
                    head_width=0.02, head_length=0.01, 
                    fc='#8B949E', ec='#8B949E', alpha=0.7)
    
    # Add side annotations
    annotations = [
        {'text': 'Flutter Widgets\nBlocBuilder/BlocListener', 'x': 0.05, 'y': 0.8},
        {'text': 'State Management\nEmit states, Handle events', 'x': 0.05, 'y': 0.65},
        {'text': 'Data Layer\nError handling, Caching', 'x': 0.05, 'y': 0.5},
        {'text': 'Type-safe APIs\n@GET, @POST, @PUT, @DELETE', 'x': 0.05, 'y': 0.35},
        {'text': 'HTTP Operations\nInterceptors, Logging', 'x': 0.05, 'y': 0.2},
    ]
    
    for ann in annotations:
        ax.text(ann['x'], ann['y'], ann['text'], 
                fontsize=10, color='#8B949E', verticalalignment='center')
    
    # Title
    ax.text(0.5, 0.95, 'Flutter Retrofit Architecture', 
            horizontalalignment='center', fontsize=20, 
            fontweight='bold', color='#F0F6FC')
    
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('/home/runner/work/BocApp/BocApp/docs/retrofit_tutorial/images/architecture_diagram.png', 
                dpi=300, bbox_inches='tight', facecolor='#0D1117')
    plt.close()

def create_code_example_image():
    """Create code example visualization"""
    fig, ax = plt.subplots(figsize=(14, 10))
    fig.patch.set_facecolor('#0D1117')
    ax.set_facecolor('#161B22')
    
    # Code example
    code = '''@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/articles')
  Future<List<Article>> getArticles(
    @Query('page') int page,
    @Query('category') String? category,
  );

  @POST('/articles')
  Future<Article> createArticle(
    @Body() CreateArticleRequest request,
  );
}'''
    
    # Add code block background
    ax.add_patch(patches.Rectangle((0.05, 0.3), 0.9, 0.5, 
                                 facecolor='#0D1117', edgecolor='#30363D', linewidth=2))
    
    # Title
    ax.text(0.5, 0.9, 'Retrofit API Service Example', 
            horizontalalignment='center', fontsize=18, 
            fontweight='bold', color='#F0F6FC')
    
    # Code text (simplified - in real implementation would use syntax highlighting)
    ax.text(0.1, 0.55, code, fontfamily='monospace', fontsize=10, 
            color='#E6EDF3', verticalalignment='center')
    
    # Benefits list
    benefits = [
        '✓ Type-safe API calls',
        '✓ Automatic code generation',
        '✓ Clean separation of concerns',
        '✓ Easy error handling',
        '✓ Built-in serialization'
    ]
    
    for i, benefit in enumerate(benefits):
        ax.text(0.1, 0.2 - i*0.03, benefit, fontsize=12, 
                color='#3FB950', fontweight='bold')
    
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('/home/runner/work/BocApp/BocApp/docs/retrofit_tutorial/images/code_example.png', 
                dpi=300, bbox_inches='tight', facecolor='#0D1117')
    plt.close()

def create_features_infographic():
    """Create features infographic"""
    fig, ax = plt.subplots(figsize=(12, 8))
    fig.patch.set_facecolor('#0D1117')
    ax.set_facecolor('#0D1117')
    
    # Title
    ax.text(0.5, 0.95, 'Retrofit Features & Benefits', 
            horizontalalignment='center', fontsize=22, 
            fontweight='bold', color='#F0F6FC')
    
    # Feature boxes
    features = [
        {'name': 'Type Safety', 'desc': 'Compile-time checking\nNo runtime errors', 'pos': (0.2, 0.75), 'color': '#58A6FF'},
        {'name': 'Code Generation', 'desc': 'Automatic implementation\nNo boilerplate code', 'pos': (0.8, 0.75), 'color': '#F79000'},
        {'name': 'Easy Testing', 'desc': 'Mockable interfaces\nUnit test friendly', 'pos': (0.2, 0.45), 'color': '#3FB950'},
        {'name': 'Dio Integration', 'desc': 'Powerful HTTP client\nInterceptors & logging', 'pos': (0.8, 0.45), 'color': '#D29922'},
        {'name': 'JSON Support', 'desc': 'Automatic serialization\nCustom converters', 'pos': (0.2, 0.15), 'color': '#DA3633'},
        {'name': 'Clean Architecture', 'desc': 'Repository pattern\nSeparation of concerns', 'pos': (0.8, 0.15), 'color': '#8957E5'}
    ]
    
    for feature in features:
        # Feature box
        circle = patches.Circle(feature['pos'], 0.12, 
                              facecolor=feature['color'], alpha=0.2,
                              edgecolor=feature['color'], linewidth=3)
        ax.add_patch(circle)
        
        # Feature name
        ax.text(feature['pos'][0], feature['pos'][1]+0.05, feature['name'], 
                horizontalalignment='center', fontsize=12, 
                fontweight='bold', color=feature['color'])
        
        # Feature description
        ax.text(feature['pos'][0], feature['pos'][1]-0.05, feature['desc'], 
                horizontalalignment='center', fontsize=9, 
                color='#8B949E')
    
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('/home/runner/work/BocApp/BocApp/docs/retrofit_tutorial/images/features_infographic.png', 
                dpi=300, bbox_inches='tight', facecolor='#0D1117')
    plt.close()

def create_linkedin_post_template():
    """Create LinkedIn post template"""
    fig, ax = plt.subplots(figsize=(10, 10))
    fig.patch.set_facecolor('#0D1117')
    ax.set_facecolor('#0D1117')
    
    # Main title
    ax.text(0.5, 0.9, '🚀 New Tutorial Released!', 
            horizontalalignment='center', fontsize=24, 
            fontweight='bold', color='#F0F6FC')
    
    ax.text(0.5, 0.82, 'Retrofit in Flutter - Complete Guide', 
            horizontalalignment='center', fontsize=18, 
            color='#58A6FF', fontweight='bold')
    
    # Key points
    points = [
        '📚 Step-by-step implementation guide',
        '💻 Real-world examples from BocApp',
        '🏗️ Clean architecture patterns',
        '🔧 Hands-on exercises & challenges',
        '🎯 Best practices & error handling',
        '📱 Production-ready code samples'
    ]
    
    for i, point in enumerate(points):
        ax.text(0.1, 0.7 - i*0.08, point, fontsize=14, 
                color='#E6EDF3', fontweight='bold')
    
    # Call to action
    ax.text(0.5, 0.15, 'Learn how to build type-safe APIs in Flutter!', 
            horizontalalignment='center', fontsize=16, 
            color='#3FB950', fontweight='bold')
    
    # Hashtags
    hashtags = '#Flutter #Retrofit #MobileDev #DartLang #API #Tutorial'
    ax.text(0.5, 0.05, hashtags, 
            horizontalalignment='center', fontsize=12, 
            color='#58A6FF', style='italic')
    
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('/home/runner/work/BocApp/BocApp/docs/retrofit_tutorial/images/linkedin_post.png', 
                dpi=300, bbox_inches='tight', facecolor='#0D1117')
    plt.close()

def main():
    """Generate all visual assets"""
    print("Generating visual assets for Retrofit tutorial...")
    
    create_tutorial_banner()
    print("✓ Tutorial banner created")
    
    create_architecture_diagram()
    print("✓ Architecture diagram created")
    
    create_code_example_image()
    print("✓ Code example image created")
    
    create_features_infographic()
    print("✓ Features infographic created")
    
    create_linkedin_post_template()
    print("✓ LinkedIn post template created")
    
    print("\nAll visual assets have been generated successfully!")
    print("Files saved in: docs/retrofit_tutorial/images/")

if __name__ == "__main__":
    main()