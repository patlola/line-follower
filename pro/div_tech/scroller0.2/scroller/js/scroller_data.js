 var stories_by_type = [
    
    
    {
      'id': 'college',
      'name': 'IIIT - Allahabad',
      'description': 'The Institute has been conceived with the ambitious objectives of developing professional expertise and skilled manpower. Ranked as one of the best institutes in the country, IIIT-A has proved to be a centre of excellence in Information Technology (IT).',
      'stories': [
        
        {
          'id': 'institute',
          'name': 'The Institute',
          'short_desc': '<a href="#">About Us</a><br><a href="#">Infrastructure</a><br><a href="#">Reaching iiita</a><br><a href="#">RTI</a>',
          'order': '1',
          'image': 1,
          'content_type': 'Video',
        },
        
        {
          'id': 'academics',
          'name': 'Academics',
          'short_desc': '<a href="#">Board of Management</a><br><a href="#">Academic Council</a><br><a href="#">Finance Committee</a><br><a href="#">Building & Works Committee</a>',
          'order': '2',
          'image': 1,
          'content_type': 'External Article',
        },
        
        {
          'id': 'student_life',
          'name': 'Student Life',
          'short_desc': '<a href="#">Fresher\'s Guide</a><br><a href="#">Photo Gallery</a><br><a href="#">Hostel Life</a><br><a href="#">Clubs</a>',
          'order': '3',
          'image': 1,
          'content_type': 'External Article',
        },
        
        {
          'id': 'facilities',
          'name': 'Facilities',
          'short_desc': '<a href="#">Laboratories</a><br><a href="#">Sports Facilities</a><br><a href="#">Medical Facilities</a>',
          'order': '4',
          'image': 1,
          'content_type': 'Video',
        },
        
                
        
        
        {
          'id': 'placements',
          'name': 'Placements',
          'short_desc': '<a href="#">BTech</a><br><a href="#">MTech</a><br><a href="#">MBA</a><br><a href="#">MS</a>',
          'order': '5',
          'image': 1,
          'content_type': 'External Article',
        },
        
        {
          'id': 'research',
          'name': 'Research Labs',
          'short_desc': '<a href="#">Student Projects</a><br><a href="#">Robotics</a><br><a href="#">Research Net</a><br><a href="#">SLIP Research Group</a>',
          'order': '6',
          'image': 1,
          'content_type': 'Video',
        },
        {
          'id': 'conclave',
          'name': 'Science Conclave',
          'short_desc': 'An interaction program of Nobel Laureates and other eminent Scientists with students and researchers during to inspire and motivate them towards careers in Basic Sciences....&nbsp;&nbsp;&nbsp;<a href="#">See More</a>',
          'order': '7',
          'image': 1,
          'content_type': 'External Article',
        }
                
        

        
      ]
    
    }
    
    
  ];

  var carousel_max = 3;
  var current_top_story = 0;
  var current_type_story = [];
  
  

  function setTopStory(story) {
    for (i=0; i<top_stories.length; i++) {
      if (i == story - 1) {
        document.getElementById('topstory' + i).className = 'jobs-topstory jobs-story-show';
        document.getElementById('topstorypage' + i).className = 'maia-pagination-dot maia-pagination-active';
      } else {
        document.getElementById('topstory' + i).className = 'jobs-topstory jobs-story-hide';
        document.getElementById('topstorypage' + i).className = 'maia-pagination-dot';
      }
    }
    current_top_story = story;
  }

  function updateTopStory(delta) {
    current_top_story += delta;
    if (current_top_story > top_stories.length) {
      current_top_story = 1;
    }
    if (current_top_story < 1) {
      current_top_story = top_stories.length;
    }
    setTopStory(current_top_story);
  }

  function setStoryTypesCarousels(all) {
    var story_types_carousels = document.getElementById('story-types');
    var html = '';
    for (i=0; i<stories_by_type.length; i++) {
      var type = stories_by_type[i];
      if (type['stories']) {
        show = 0;
        html += '<div class="jobs-stories">';
        html += '  <div class="jobs-stories-desc">';
        html += '    <h2><br><br>' + type['name'] + '</h2>';
        html += '    ' + type['description'];
        html += '  </div>';
        html += '  <div class="jobs-stories-container" id="type' + i + '">';
        current_type_story[i] = show;
        if (all) {
          max = type['stories'].length;
        } else {
          max = 3;
        }
        for (j=0; j<max; j++) {
          var story = type['stories'][j];
          count = j + 1;
          if (count > carousel_max) {
            html += '    <div class="jobs-story-hide" id="type' + i + 'story' + j + '">';
          } else {
            html += '    <div class="jobs-story-show" id="type' + i + 'story' + j + '">';
          }
          if (story['image']) {
            html += '      <a href="' + story['id'] + '.html" data-g-event="Life at Google - Story Click" data-g-label="' + type['name'] + ' - ' + story['order'] + '" data-g-action="' + story['name'] + '"';
            if (story['content_type'] == "Internal Article" ) html += ' class="jobs-story-ia"';
            if (story['content_type'] == "External Article" ) html += ' class="jobs-story-ea"';      
            if (story['content_type'] == "Video" ) html += ' class="jobs-story-vid"';
            html += '><img src="imgs/img_' + story['id'] + '.jpg" alt=""/></a>';
          }
          html += '      <h3>' + story['name'] + '</h3>';
          html += '      <p class="desc">' + story['short_desc'] + '</p>';
         
          html += '    </div>';
        }
        html += '  </div>';
        if (type['stories'].length >= max) {
          html += '    <div class="maia-pagination-nav jobs-pagination-stories">';
          html += '      <ul>';
          for (j=0; j<(type['stories'].length/carousel_max); j++) {
            if (current_type_story[i] == j) {
              html += '        <li><span class="maia-pagination-dot maia-pagination-active" onclick="setTypePage(' + i + ', ' + j + ');" id="type' + i + 'page' + j + '" style="-webkit-user-select: none;">Page 1</span></li>';
            } else {
              html += '        <li><span class="maia-pagination-dot" onclick="setTypePage(' + i + ', ' + j + ');" id="type' + i + 'page' + j + '" style="-webkit-user-select: none;">Page 1</span></li>';
            }
          }
          html += '        <li><span class="maia-pagination-prev" onclick="updateTypePage(' + i + ', -1);" style="-webkit-user-select: none; ">Previous</span></li>';
          html += '        <li><span class="maia-pagination-next" onclick="updateTypePage(' + i + ', 1);" style="-webkit-user-select: none; ">Next</span></li>';
          html += '      </ul>';
          html += '    </div>';
        }
        html += '  </div>';
      }
      html += '</div>';
    }
    story_types_carousels.innerHTML = html;
  }

  function setTypePage(type, page) {
    for (i=0; i<stories_by_type[type]['stories'].length; i++) {
      if (i >= (page * carousel_max) && i < ((page + 1) * carousel_max)) {
        if (i == (page * carousel_max)) {
          document.getElementById('type' + type + 'story' + i).className = 'jobs-story-show jobs-story-first';
        } else {
          document.getElementById('type' + type + 'story' + i).className = 'jobs-story-show';
        }
      } else {
        document.getElementById('type' + type + 'story' + i).className = 'jobs-story-hide';
      }
    }
    for (i=0; i<(stories_by_type[type]['stories'].length/carousel_max); i++) {
      if (i == page) {
        document.getElementById('type' + type + 'page' + i).className = 'maia-pagination-dot maia-pagination-active';
      } else {
        document.getElementById('type' + type + 'page' + i).className = 'maia-pagination-dot';
      }
    }
    current_type_story[type] = page;
  }

  function updateTypePage(type, delta) {
    current_type_story[type] += delta;
    if (current_type_story[type] >= (stories_by_type[type]['stories'].length / carousel_max)) {
      current_type_story[type] = 0;
    }
    if (current_type_story[type] < 0) {
      current_type_story[type] = Math.ceil(stories_by_type[type]['stories'].length / carousel_max) - 1;
    }
    setTypePage(type, current_type_story[type]);
  }