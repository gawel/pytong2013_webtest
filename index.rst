
.. impress::
   :func: linear

=======================
Tu peux webtest
=======================

.. slide::
   :class: first center

Gael Pasgrimaud `@gawel_ <http://twitter.com/gawel_>`_

2013

About me
========

- Pythonista `@bearstech <http://twitter.com/bearstech>`_

- Membre fondateur de l'`AFPy <http://www.afpy.org>`_

- Mainteneur WebTest

- Et autres... https://github.com/gawel

About WSGI
==========

- Web Server Gateway Interface

- Standardisation des échanges

::

    server <=> middleware <=> applications

- Tous les frameworks respectent cette norme

Testing!
========

- Nul ne conteste l'importance des tests

- Test unitaire vs Test fonctionnel

WebTest
=======

- Orienté test fonctionel

- Remplace un serveur WSGI pour simuler un client web

- Testé!

Les basiques
============

::

    def my_application(environ, start_response):
        if environ['PATH_INFO'] == '/':
            status = '200 OK'
            body = 'It Works!'
        else:
            status = '404 Not Found'
            body = 'You loose'
        start_response(
            status,
            [
                ('Content-Type', 'text/plain'),
                ('Content-Length', str(len(body)))
            ]
        )
        return [body]


Une première requète
====================

::

    >>> app = TestApp(my_application)

    >>> resp = app.get('/', status='*')

    >>> assert resp.status_int == 200
    >>> resp.mustcontain('Welcome!')


Clicker
=======

::

    >>> resp = resp.click('Login')

Tester des formulaires
=======================

::

    >>> form = resp.forms['login_form']
    >>> form.lint()

    >>> form['login'] = 'gawel'
    >>> form['password'] = 'passwd'

    >>> resp = form.submit()

Permet l'upload de fichier.

Certain contrôles sont effectués quand on défini la valeur d'un champs.

Tester la réponse
======================

Avec minidom::

    >>> resp.xml

Avec lxml/pyquery::

    >>> resp.lxml
    >>> resp.pyquery

Avec json::

    >>> resp.json

Tester une api
==============

::

    >>> assert 'my_ressource' in app.get('/v1').json

::

    >>> resp = app.post_json('/v1/my_ressource', {'foo': 'bar'})

Envois un bon Content-Type

Methodes GET POST PUT PATCH OPTIONS DELETE implémentées

Tester le consomateur de l'api
==============================

::

    class TestWebApp(unnitest.TestCase):

        def setUp(self):
            self.api = webtest.http.StopableWSGIServer(my_api)
            self.api.start()
            self.webapp = TestApp(my_webapp(api_url=self.api.application_url))

        def tearDown(self):
            self.api.shutdown()


- Lance un vrai server web (waitress)

Tester la prod!
===============

::

    >>> app = TestApp('http://bearstech.com')

- Utilise WSGIProxy2 pour executer les requètes.

- Permet aussi de tester du PHP voir du Java!!

Utiliser un vrai navigateur
===========================

- webtest-selenium https://github.com/gawel/webtest-selenium

- webtest-casperjs https://github.com/gawel/webtest-casperjs

Autres Librairies
==================

- Django: https://github.com/kmike/django-webtest

- Test de charges: loads https://github.com/mozilla-services/loads


Et voilà!
=========

Des questions ?
