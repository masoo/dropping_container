@engine_init = ->
  return Matter.Engine.create()

@render_init = (engine) ->
  return Matter.Render.create({
    element: lolipop,
    engine: engine,
    options: {
      width: 700,
      height: 1000,
      background: '#fc3',
      wireframes: false
    }
  })

@square_container = (x, y) ->
  return Matter.Bodies.rectangle(
    x, y, 80, 80, {
      render: {
        sprite: {
          texture: '/mini.png'
        }
      }
    }
  )

@oblong_container = (x, y) ->
  return Matter.Bodies.rectangle(
    x, y, 193, 80, {
      render: {
        sprite: {
          texture: '/long.png'
        }
      }
    }
  )

@ground_triangle = (x, y) ->
  return Matter.Bodies.polygon(x, y, 3, 40)

@ground_pin = (xx, yy, ground_triangle) ->
  return Matter.Constraint.create({
    pointA: {x: xx, y: yy},
    bodyB: ground_triangle,
    stiffness: 0,
    length: 0
  })

@ground_triangles = (x, y) ->
  matters = []
  positions = [{xx: x, yy: y}, {xx: x + (140 * 1), yy: y - 100}, {xx: x + (140 * 2), yy: y}, {xx: x + (140 * 3), yy: y - 100}]
  for i,position of positions
    ground_triangle_a = ground_triangle(position.xx, position.yy)
    pin_a = ground_pin(position.xx, position.yy, ground_triangle_a)
    matters.push(ground_triangle_a)
    matters.push(pin_a)
  return matters

@drag_option = (engine, render) ->
  mouse = Matter.Mouse.create(render.canvas)
  mousedrag = Matter.MouseConstraint.create(engine, {
    mouse: mouse,
    constraint: {
        stiffness: 0.1,
        render: {
            visible: false
        }
    }
  });
  return mousedrag

$(document).on 'turbolinks:load', ->
  window.global_engine = engine_init()
  render = render_init(window.global_engine)

  matters = []
  triangles = ground_triangles(100, 900)
  matters = matters.concat(triangles)

  mousedrag = drag_option(window.global_engine, render)
  Matter.World.add(window.global_engine.world, mousedrag);

  Matter.World.add(window.global_engine.world, matters)
  Matter.Engine.run(window.global_engine)
  Matter.Render.run(render)
  return